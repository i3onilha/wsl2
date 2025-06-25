#!/bin/bash
set -e

# Variáveis
GO_VERSION=1.24.4

echo "[1/9] Instalando Golang ${GO_VERSION}"
wget -q https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
rm go${GO_VERSION}.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

echo "[2/9] Instalando kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl && mv kubectl /usr/local/bin/

echo "[3/9] Instalando Minikube"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

echo "[4/9] Instalando pacotes via APT"
apt-get update
apt-get upgrade -yqq
apt-get install -yqq \
  apt-utils \
  gnupg2 \
  git \
  libzip-dev zip unzip \
  default-mysql-client \
  inetutils-ping \
  wget \
  libaio-dev \
  freetds-dev \
  sudo \
  bash-completion \
  curl \
  make \
  ncurses-dev \
  build-essential \
  tree \
  nano \
  tmux \
  tmuxinator \
  xclip \
  apt-transport-https \
  ca-certificates \
  gnupg-agent \
  software-properties-common \
  libssl-dev \
  libgtk-3-dev \
  nsis \
  ripgrep \
  fontconfig \
  gcc
rm -rf /var/lib/apt/lists/*

echo "[5/9] Instalando Nerd Fonts"
mkdir -p /usr/share/fonts/truetype/nerd-fonts
wget -O /tmp/nerd-fonts.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip
unzip /tmp/nerd-fonts.zip -d /usr/share/fonts/truetype/nerd-fonts
rm /tmp/nerd-fonts.zip
fc-cache -fv

echo "[6/9] Instalando Neovim"
curl -LO https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-linux64.tar.gz
tar -C /opt -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz

echo "[7/9] Ajustando fuso horário"
ln -sf /usr/share/zoneinfo/America/Manaus /etc/localtime

echo "[8/9] Ajustando fuso horário"
sudo apt-get update
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
