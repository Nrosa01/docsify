#! /bin/sh

if [ "$HOST" ]
then
  mkdir -p -m 0600 ~/.ssh && ssh-keyscan "$HOST" >> ~/.ssh/known_hosts
fi

# Clone repo if not done already
if ! git status > /dev/null 2>&1
then
  git clone "$GIT_REPO" repo || exit 1
fi

cd repo

if [ "$BRANCH" ]
then
  git checkout "$BRANCH"
fi


# Start docsify in background
docsify serve . &
docsifyPid=$!
sleepPid=

# Forward signals to blocking processes
stop() {
  kill -s "$1" "$docsifyPid"
  if test "$1" != "SIGHUP"
  then
    # We're expecting docsify to stop
    wait "$docsifyPid"
  fi
  kill -s "$1" "$sleepPid"
}

trap 'stop SIGHUP' SIGHUP
trap 'stop SIGINT' SIGINT
trap 'stop SIGQUIT' SIGQUIT
trap 'stop SIGTERM' SIGTERM

# While docsify is running
while kill -0 "$docsifyPid"
do
  git pull
  sleep "$INTERVAL" &
  sleepPid=$!
  wait "$sleepPid"
done
