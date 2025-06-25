#!/bin/bash
set -e

NODE_VERSION=v22.17.0
NVM_DIR="${HOME}/.nvm"

echo "[1/3] Setting docker group for $USER"
sudo usermod -aG docker $USER
newgrp docker
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
git config --global user.email "jeanbonilha.webdev@gmail.com"
git config --global user.name "Jean Bonilha"

echo "[2/3] Instalando ferramentas Go"
go install golang.org/x/tools/cmd/godoc@v0.5.0
go install github.com/kyleconroy/sqlc/cmd/sqlc@v1.18.0
go install github.com/air-verse/air@v1.52.3
go install github.com/swaggo/swag/cmd/swag@v1.16.4

echo "[3/3] Configurando ambiente do usuário 'go'"
mkdir -p ${NVM_DIR}
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
source $HOME/.nvm/nvm.sh
nvm install ${NODE_VERSION}
nvm use ${NODE_VERSION}
nvm alias default ${NODE_VERSION}
npm config set fetch-retries 2
npm config set fetch-retry-factor 10
npm config set fetch-retry-mintimeout 10000
npm config set fetch-retry-maxtimeout 60000
npm install -g yarn
npm install -g npm
git clone --depth=1 https://github.com/i3onilha/nvim $HOME/.config/nvim
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install --all
git clone --depth=1 --bare -b godevenv https://github.com/i3onilha/.dotfiles.git $HOME/.dotfiles
git clone --depth=1 https://github.com/i3onilha/.tmux.git $HOME/.tmux
ln -sf .tmux/.tmux.conf $HOME
cp $HOME/.tmux/.tmux.conf.local $HOME
