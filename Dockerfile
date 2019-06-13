FROM ubuntu:18.04
MAINTAINER Koen De Keyser <koen.dekeyser@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

## pre-seed tzdata, update package index, upgrade packages and install needed software
RUN echo "tzdata tzdata/Areas select Europe" > /tmp/preseed.txt; \
    echo "tzdata tzdata/Zones/Europe select Brussels" >> /tmp/preseed.txt; \
    debconf-set-selections /tmp/preseed.txt && \
    apt-get update -q && \
    apt-get install -y --no-install-recommends tzdata

RUN apt-get update -q && apt-get install -y --no-install-recommends \
  sudo \
  gcc \
  g++ \
  make \
  tmux \
  wget \
  software-properties-common \
  vim \ 
  libnotify4 \
  libnss3 \
  libxtst6 \
  libxss1 \
  libsecret-1-0 \
  libxkbfile1 \
  libx11-xcb1 \
  libgconf-2-4 \
  libgtk2.0-0 \
  libasound2 \
  git \
  fish \
  curl \
  lcov \
  fish \
  tmux \
  vim-gnome \
  libtinfo-dev \
  zip \
  unzip \
  net-tools \
  ssh \
  gpg-agent \
  gnupg \
  locales \
  lldb


ENV VSCODE_VERSION 1.35.1
RUN wget -O /tmp/vscode.deb https://vscode-update.azurewebsites.net/$VSCODE_VERSION/linux-deb-x64/stable/
RUN dpkg -i /tmp/vscode.deb && rm /tmp/vscode.deb && apt-get -f install

RUN groupadd -g 1000 developer && useradd -u 1000 -g 1000 developer
RUN echo "developer:developer" | chpasswd 
RUN adduser developer sudo 
RUN mkdir /home/developer
RUN chown developer /home/developer

# make fish the default shell
RUN chsh -s /usr/bin/fish developer

USER developer 
RUN wget -O /tmp/rustup.sh https://sh.rustup.rs && sh /tmp/rustup.sh -y
ENV PATH $PATH:/home/developer/.cargo/bin
RUN rustup component add rls-preview rust-analysis rust-src rustfmt
RUN echo 0 | code --install-extension rust-lang.rust
RUN echo 0 | code --install-extension vadimcn.vscode-lldb

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US.UTF-8



#workaround for fish issue: https://github.com/fish-shell/fish-shell/issues/5180
ENV USER developer

ENTRYPOINT ["/usr/bin/tmux"]
