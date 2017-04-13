# docker-golang-dev

Build a Go development environment in Docker container.

Following tools are preinstalled:

* zsh: the shell
* vim: default editor
* silversearcher-ag: faster grep
* curl: to download or test APIs
* nginx: reverse proxy for apps built in the container
* locales: setup UTF-8
* sudo: enable /etc/sudoers

## Usage

    docker exec -it yanhao/docker-golang-dev zsh
