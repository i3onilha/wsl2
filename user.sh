sudo usermod -aG docker $USER
newgrp docker
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
git config --global user.email "jeanbonilha.webdev@gmail.com"
git config --global user.name "Jean Bonilha"
