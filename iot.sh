#~/bin/bash
echo "Setup device as REE IoT"
sudo apt update
#sudo apt upgrade -y
sudo systemctl enable ssh
sudo systemctl start ssh
sudo apt install npm vim git -y

# change password
echo -e "raspberry\nReeIoT001\nReeIoT001" | passwd

# ngrok
cd ~
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip
unzip ngrok-stable-linux-arm.zip
sudo mv ngrok /usr/bin

# ssh over ngrok
cd ~
wget -cO - https://github.com/sanbt364/ssh-over-ngrok/archive/refs/tags/v1.0.zip > ssh-over-ngrok.zip
unzip ssh-over-ngrok.zip
cd ssh-over-ngrok-1.0
read -p "Enter site ID: " siteid
echo -e "\nNGROK_SITE=\"$siteid\"\n" >> .env
npm install

# startup
sudo npm install pm2@latest -g
sudo pm2 startup
sudo pm2 start index.js --name ssh-ngrok-service
sudo pm2 save

cd ~
make -p .ssh
touch .ssh/authorized_keys
echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC72o/EfPxL+4Egmvi3wzY8u/ufCugZrTPCfmoaCdwJyA/Ls32EfFvdyBvIXVrr+qhDnWJK87drESEu6+hLI2obmVlxolj70x1daYCJoB1Aklck914ZzSy5XArJ+0Gf31SgfPwKc1HgHl2ub59rAWmyaXgLDBYt6+2KaJlzJ+ZlAN0o/l0O1qygr7jOfdvkY8QMwZet4tHgvKdOaUhl/I8ngExcNaVBeeBoHNiT9EJgVaCZHjKvvx6ekZdzhr7876S4mF2ZXGqFaDNNxAfD7g1v0IjkC27Kl/wXZZEAglBIt0KNCJiLy1wPqJM7ElYYVloGpuR2CxKEmh0hx/DLJ/0edmvAGOI5OvnAy7YWYbK3JxB5GSTUYruiceWKj3V9VA2ythr2culSOcpDCG3pEz3VsFOpWFVL6bYGOSPr77ZiMu2TX77FiWxxzbdP0cztVWyJu5SJNtbJI34dyM21/8RcaDiE3FZlay9cl7xgB7cYP+Ip1P7rw3h/O2P+rrbYpwU= sanbt@btsan\n" >> ~/.ssh/authorized_keys

