# **************************************************************************
# Purpose ...: Compilation of FriCAS (official SF version)
# Build .... : docker build -t singularitti/fricas:latest .
# Version .. : 02-FEB-2019
# OS ....... : ubuntu:latest
# **************************************************************************

FROM ubuntu:latest

# ENV DEBIAN_FRONTEND noninteractive
# discouraged: see https://docs.docker.com/engine/faq/

ENV FRICAS_SF https://sourceforge.net/projects/fricas/files/fricas
ENV FRICAS_VERSION 1.3.5

# ======================================
# Get packages and install missing tools
# ======================================

RUN apt-get -qq update && apt-get -qq upgrade -y && apt-get -qq install -y -q \
    build-essential \
    make \
    gcc \
    sbcl \
    cl-quicklisp \
    cl-asdf \
    zlib1g-dev \
    git \
    libcurl4-openssl-dev \
    wget \
    libx11-dev \
    libxt-dev \
    libice-dev \
    libsm-dev \
    libxau-dev \
    libxdmcp-dev \
    libxpm-dev \
    dvipng \
    auctex \
    net-tools \
    inetutils-ping \
    zsh \
    vim && \
    apt-get -qq autoclean && apt-get -qq autoremove


# =====================
# Install zsh framework
# =====================

SHELL ["/usr/bin/zsh", "-c"]

RUN cd /root && zsh && \
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" && \
    setopt EXTENDED_GLOB && \
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done

COPY .zpreztorc /root/


# =====================
# Install vim framework
# =====================

RUN git clone --depth=1 https://github.com/amix/vimrc.git /root/.vim_runtime && \
    sh /root/.vim_runtime/install_awesome_vimrc.sh

COPY my_configs.vim /root/.vim_runtime/


# =============================
# FriCAS (may take some time ;)
# =============================

RUN cd /root && \
    wget $FRICAS_SF/$FRICAS_VERSION/fricas-$FRICAS_VERSION-full.tar.bz2 && \
    tar xvf fricas-$FRICAS_VERSION-full.tar.bz2 && \
    cd fricas-$FRICAS_VERSION && ./configure --with-lisp=sbcl --with-x && \
    make -k > build.log 2>&1 && make install && \
    cd /root && rm -r fricas-$FRICAS_VERSION && rm fricas-$FRICAS_VERSION-full.tar.bz2


# ===============
# Start container
# ===============

CMD cd /root && zsh
