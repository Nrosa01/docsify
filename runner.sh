#! /bin/sh
set -x  # Trace all commands

echo "[INFO] Starting runner.sh script"

if [ "$HOST" ]; then
  echo "[INFO] Adding $HOST to known_hosts"
  mkdir -p -m 0600 ~/.ssh
  ssh-keyscan "$HOST" >> ~/.ssh/known_hosts
fi

echo "[INFO] Checking if repo is already cloned"
if ! git status > /dev/null 2>&1; then
  echo "[INFO] Repo not found, cloning from $GIT_REPO"
  git clone "$GIT_REPO" . || { echo "[ERROR] git clone failed"; exit 1; }
else
  echo "[INFO] Repo exists, skipping clone"
fi

echo "[INFO] Changing directory to repo"
cd repo || { echo "[ERROR] Cannot cd to repo"; exit 1; }

if [ "$BRANCH" ]; then
  echo "[INFO] Checking out branch $BRANCH"
  git checkout "$BRANCH" || { echo "[ERROR] git checkout failed"; exit 1; }
fi

echo "[INFO] Generating nginx config"
envsubst < /template.conf > /etc/nginx/conf.d/default.conf
nginx -t || { echo "[ERROR] nginx config test failed"; exit 1; }

echo "[INFO] Starting nginx in background"
nginx -g "daemon off;" &
nginxPid=$!
sleepPid=

stop() {
  echo "[INFO] Stopping processes"
  kill -s "$1" "$nginxPid"
  if [ "$1" != "SIGHUP" ]; then
    wait "$nginxPid"
  fi
  kill -s "$1" "$sleepPid"
}

trap 'stop SIGHUP' SIGHUP
trap 'stop SIGINT' SIGINT
trap 'stop SIGQUIT' SIGQUIT
trap 'stop SIGTERM' SIGTERM

echo "[INFO] Entering main loop with interval $INTERVAL"
while kill -0 "$nginxPid"; do
  echo "[INFO] Pulling latest changes"
  git pull || echo "[WARN] git pull failed"
  sleep "$INTERVAL"
done
