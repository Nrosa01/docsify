# Docsify
A docker image to serve an updated docsify repo

## Usage
Run the image specifying `GIT_REPO` and optionally additional environment
variables. All available are specified below:

| Name         | Default | Description                                   |
|--------------|---------|-----------------------------------------------|
| GIT_REPO     |         | Url of git repo to clone                      |
| INTERVAL     | 3600    | How many seconds in between git pulls         |
| HOST         |         | Host of the git repo, needed if using ssh keys|
