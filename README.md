# Members
[![CircleCI](https://circleci.com/gh/cltorresfe/members.svg?style=shield&circle-token=5c9cea46dc919158430b7a9956276e05ca0033bb)](https://circleci.com/gh/cltorresfe/members)
[![Coverage Status](https://coveralls.io/repos/github/cltorresfe/members/badge.svg?branch=master)](https://coveralls.io/github/cltorresfe/members?branch=master)
[![Code Climate](https://codeclimate.com/github/cltorresfe/members/badges/gpa.svg)](https://codeclimate.com/github/cltorresfe/members)
[![Dependency Status](https://gemnasium.com/badges/github.com/cltorresfe/members.svg)](https://gemnasium.com/github.com/cltorresfe/members)
[![Inline docs](http://inch-ci.org/github/cltorresfe/members.svg?branch=master)](http://inch-ci.org/github/cltorresfe/members)
[![Stories in Ready](https://badge.waffle.io/cltorresfe/members.svg?label=ready&title=Ready)](http://waffle.io/cltorresfe/members)

## Requerimientos
- PostgreSQL
- Redis

## Configuracion
Para correr capybara-webkit en Ubuntu es necesario instalar:

```shell
sudo apt-get install libqtwebkit-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x
```

Para correr capybara-webkit en OS X es necesario:

```shell
brew tap homebrew/versions
brew install qt55
brew link --force qt55
which qmake
```

Instalar bower en Ubuntu:

```shell
apt-get update
apt-get install build-essential libssl-dev
# Primero hay que instalar nvm
curl https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash
nvm install stable
sudo npm install -g bower
installar gemas de bower
bower init
bower install
```

Instalar bower en os x

```shell
brew install node
sudo npm install -g bower
```

Instalar redis en os x

```shell
brew install redis
brew services start redis
```

Para instalar therubyracer

```shell
gem uninstall libv8
brew install v8
gem install libv8 -v '3.16.14.13' -- --with-system-v8
gem install therubyracer -- --with-v8-dir=/usr/local/opt/v8-#622424
```

## Ejecución

### Desarrollo

- Para ejecutar el servicio web, desde la consola escribir `rails s`.
- Para ejecutar el servicio de sidekiq escribir `bundle exec sidekiq`
- En caso de querer ejecutar ambos servicios escribir `foreman start`.

### Heroku
- Para crear nueva instancia:

```shell
heroku create
# Para poder compilar dependencias bower
heroku config:set BUILDPACK_URL='git://github.com/qnyp/heroku-buildpack-ruby-bower.git#run-bower'
git push heroku master
```
