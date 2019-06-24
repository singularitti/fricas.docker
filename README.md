# fricas.docker
[![Build Status](https://travis-ci.com/singularitti/fricas.docker.svg?branch=master)](https://travis-ci.com/singularitti/fricas.docker)

[TOC]

## Install

This docker file is referenced from [`nilqed/fricas_docker`](https://github.com/nilqed/fricas_docker/tree/master/fricas).
This image is hosted on [`singularitti/fricas`](https://hub.docker.com/r/singularitti/fricas), please download by

```shell
docker pull singularitti/fricas
```

To create a container, run

```shell
docker create --name fricas -t -i singularitti/fricas
```

and start it by

```shell
docker start -a -i friacs
```

## Content

- Ubuntu 18.04.1 LTS (`cat /etc/*release`)
- SBCL 1.4.5.debian (64bit)
- FriCAS 1.3.5 compiled at Sun Feb 3 13:45:44 CET 2019
- `zsh` and [`Prezto`](https://github.com/sorin-ionescu/prezto) framework
- `vim` and ["The Ultimate vimrc" configuration](https://github.com/amix/vimrc)
- see [Dockerfile](https://github.com/singularitti/fricas.docker/blob/master/Dockerfile)
