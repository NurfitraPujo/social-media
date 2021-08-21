## Install Dependencies

```bash
sudo apt update

sudo apt install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev dirmngr gnupg apt-transport-https ca-certificates mysql-server libmysqlclient-dev
```

## Install RBENV

Clone the libraries

```bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
git clone https://github.com/rbenv/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars
```

Add rbenv to the PATH

```bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
```

Reload the shell

```bash
exec $SHELL
```

## Install Ruby

```bash
rbenv install 3.0.1
rbenv global 3.0.1
```

## Install Bundler

```bash
gem install bundler
```

## Compress the app

```bash
 tar --exclude='./.git' --exclude='./coverage' --exclude='./spec' --exclude='./public' -zcvf social-media.tar.gz .
```

## Copy archive into server machine

```bash
scp social-media.tar.gz username@address:/dir
```
