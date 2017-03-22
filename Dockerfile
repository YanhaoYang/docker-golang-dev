FROM golang:1.8
MAINTAINER Yanhao Yang <yanhao.yang@gmail.com>

# Development tools
RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
  zsh vim-nox silversearcher-ag curl nginx locales sudo && \
  apt-get autoremove -y && \
  apt-get autoclean && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN \
  chsh --shell /bin/zsh && \
  echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen && \
  groupadd --gid 1000 docker && \
  useradd --gid 1000 --uid 1000 --create-home docker && \
  echo "docker ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user && \
  chmod 0440 /etc/sudoers.d/user && \
  chown -R docker:docker /var/lib/nginx && \
  chown -R docker:docker /var/log/nginx && \
  chown -R docker:docker /go && \
  wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && \
  chmod +x /usr/local/bin/dumb-init

COPY files/nginx.conf /etc/nginx/nginx.conf

ENV TERM=xterm-256color

# To make oh-my-zsh installer happy
ENV SHELL=/usr/bin/zsh

USER docker

RUN \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
   git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
  mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim && \
  git clone https://github.com/YanhaoYang/vim-go-ide.git ~/.vim_go_runtime && \
  sh ~/.vim_go_runtime/bin/install && \
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
  ~/.fzf/install --all && \
  go get -v github.com/nsf/gocode && \
  go get -v github.com/alecthomas/gometalinter && \
  go get -v golang.org/x/tools/cmd/goimports && \
  go get -v golang.org/x/tools/cmd/guru && \
  go get -v golang.org/x/tools/cmd/gorename && \
  go get -v github.com/golang/lint/golint && \
  go get -v github.com/rogpeppe/godef && \
  go get -v github.com/kisielk/errcheck && \
  go get -v github.com/jstemmer/gotags && \
  go get -v github.com/klauspost/asmfmt/cmd/asmfmt && \
  go get -v github.com/fatih/motion && \
  go get -v github.com/zmb3/gogetdoc && \
  go get -v github.com/josharian/impl && \
  go get -u github.com/golang/dep/... && \
  go get github.com/onsi/ginkgo/ginkgo

COPY files/.zshrc /home/docker/.zshrc

WORKDIR /go/src
ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
