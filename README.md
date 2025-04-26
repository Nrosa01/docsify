# Docsify
A docker image to serve an updated docsify repo

## Usage
Run the image specifying `GIT_REPO` and optionally aditional environment
variables. All avalable are specified below:

| Name         | Default | Description                             |
|--------------|---------|-----------------------------------------|
| GIT_REPO     |         | Url of git repo to clone                |
| INTERVAL     | 3600    | How many seconds in between git pulls   |
