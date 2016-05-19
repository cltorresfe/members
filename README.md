# Members

## Configuracion
Para correr capybara-webkit en Ubuntu es necesario instalar:

```
sudo apt-get install libqtwebkit-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x
```

Instalar bower en Ubuntu:

```
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

## Heroku
Para crear nueva instancia:

```
heroku create
# Para poder compilar dependencias bower
heroku config:set BUILDPACK_URL='git://github.com/qnyp/heroku-buildpack-ruby-bower.git#run-bower'
git push heroku master
```
