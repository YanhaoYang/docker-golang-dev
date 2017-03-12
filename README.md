# docker-golang-dev

Build a Go development environment in Docker container.

Following tools are preinstalled:

* zsh: the shell
* vim-nox: vim with Python (required by [ultisnips](https://github.com/SirVer/ultisnips))
* silversearcher-ag: faster grep
* curl: to download or test APIs
* nginx: reverse proxy for apps built in the container
* locales: setup UTF-8
* sudo: enable /etc/sudoers

For VIM, a customized [vim-go-ide)](https://github.com/YanhaoYang/vim-go-ide) has been deployed.

## Usage

    docker exec -it golang-dev zsh
