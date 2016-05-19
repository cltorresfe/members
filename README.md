# Members

## Configuracion
Para correr capybara-webkit en Ubuntu es necesario instalar:

```
sudo apt-get install libqtwebkit-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x
```

Para correr capybara-webkit en OS X es necesario:
	
``` 
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

``` 
brew install node
sudo npm install -g bower
```

Para instalar therubyracer

```
gem uninstall libv8
brew install v8
gem install libv8 -v '3.16.14.13' -- --with-system-v8
gem install therubyracer -- --with-v8-dir=/usr/local/opt/v8-#622424
```

## Heroku
- Para crear nueva instancia:

```shell
heroku create
# Para poder compilar dependencias bower
heroku config:set BUILDPACK_URL='git://github.com/qnyp/heroku-buildpack-ruby-bower.git#run-bower'
git push heroku master
```
