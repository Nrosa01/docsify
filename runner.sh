#! /bin/sh

# Clone repo if not done already
if ! git status > /dev/null 2>&1
then
  git clone "$GIT_REPO" . || exit 1
fi

# Generate nginx config
envsubst < /template.conf > /etc/nginx/conf.d/default.conf

# Start nginx in background
nginx -g "daemon off;" &
nginxPid=$!
sleepPid=

# Forward signals to blocking processes
stop() {
  kill -s "$1" "$nginxPid" &
  kill -s "$1" "$sleepPid"
}

trap 'stop SIGHUP' SIGHUP
trap 'stop SIGINT' SIGINT
trap 'stop SIGQUIT' SIGQUIT
trap 'stop SIGTERM' SIGTERM

# While nginx is running
while kill -0 "$nginxPid"
do
  git pull
  sleep "$INTERVAL" &
  sleepPid=$!
  wait "$sleepPid"
done
