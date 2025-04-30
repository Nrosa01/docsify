# Docsify
A docker image to serve an updated docsify repo

## Usage
Run the image specifying `GIT_REPO` and optionally additional environment
variables. All available are specified below:

| Name         | Default | Description                                    |
|--------------|---------|------------------------------------------------|
| GIT_REPO     |         | Url of git repo to clone                       |
| SUBDIR       | /       | Subdirectory to serv from e.g. `/dist`         |
| LOCATION_CFG |         | Additional config in `location /`-block        |
| SERVER_CFG   |         | Additional config in `server`-block            |
| INTERVAL     | 3600    | How many seconds in between git pulls          |
| HOST         |         | Host of the git repo, needed if using ssh keys |
| BRANCH       |         | Branch of the repo to use                      |
