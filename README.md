# Serve-Repo
A docker image to serve static files from a git repo and keep them up to date.

## Usage
Run the image specifying `GIT_REPO` and optionally aditional environment
variables. All avalable are specified below:

| Name         | Default | Description                             |
|--------------|---------|-----------------------------------------|
| GIT_REPO     |         | Url of git repo to clone                |
| SUBDIR       | /       | Subdirectory to serv from e.g. `/dist`  |
| LOCATION_CFG |         | Additional config in `location /`-block |
| SERVER_CFG   |         | Additional config in `server`-block     |
| INTERVAL     | 3600    | How many seconds in between git pulls   |
