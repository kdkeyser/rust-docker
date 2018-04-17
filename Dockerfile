FROM ubuntu:16.04

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
  lldb-5.0


#workaround on Ubuntu 16.04 for LLDB, see https://github.com/vadimcn/vscode-lldb/wiki/Installing-on-Linux
RUN ln -s /usr/bin/lldb-server-5.0 /usr/lib/llvm-5.0/bin/lldb-server-5.0.0

ENV VSCODE_VERSION 1.22.2
RUN wget -O /tmp/vscode.deb https://vscode-update.azurewebsites.net/$VSCODE_VERSION/linux-deb-x64/stable/
RUN dpkg -i /tmp/vscode.deb && rm /tmp/vscode.deb && apt-get -f install

RUN groupadd -g 1000 developer && useradd -u 1000 -g 1000 developer
RUN echo "developer:developer" | chpasswd 
RUN adduser developer sudo 
RUN mkdir /home/developer
RUN chown developer /home/developer

USER developer 
RUN wget -O /tmp/rustup.sh https://sh.rustup.rs && sh /tmp/rustup.sh -y
ENV PATH $PATH:/home/developer/.cargo/bin
RUN rustup component add rls-preview rust-analysis rust-src
RUN echo 0 | code --install-extension rust-lang.rust
RUN echo 0 | code --install-extension vadimcn.vscode-lldb
