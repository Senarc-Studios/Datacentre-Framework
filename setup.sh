clear

echo "";
echo "  ██████ ▓█████ ███▄    █  ▄▄▄       ██▀███  ▄████▄                                  ";
echo "▒██    ▒ ▓█   ▀ ██ ▀█   █ ▒████▄    ▓██ ▒ ██▒██▀ ▀█                                  ";
echo "░ ▓██▄   ▒███  ▓██  ▀█ ██▒▒██  ▀█▄  ▓██ ░▄█ ▒▓█    ▄                                 ";
echo "  ▒   ██▒▒▓█  ▄▓██▒  ▐▌██▒░██▄▄▄▄██ ▒██▀▀█▄ ▒▓▓▄ ▄██▒                                ";
echo "▒██████▒▒░▒████▒██░   ▓██░ ▓█   ▓██▒░██▓ ▒██▒ ▓███▀ ░                                ";
echo "▒ ▒▓▒ ▒ ░░░ ▒░ ░ ▒░   ▒ ▒  ▒▒   ▓▒█░░ ▒▓ ░▒▓░ ░▒ ▒  ░                                ";
echo "░ ░▒  ░ ░ ░ ░  ░ ░░   ░ ▒░  ▒   ▒▒ ░  ░▒ ░ ▒░ ░  ▒                                   ";
echo "░  ░  ░     ░     ░   ░ ░   ░   ▒     ░░   ░░                                        ";
echo "      ░     ░  ░        ░       ░  ░   ░    ░ ░                                      ";
echo "                                            ░                                        ";
echo "▓█████▄  ▄▄▄     ▄▄▄█████▓ ▄▄▄      ▄████▄ ▓█████ ███▄    █ ▄▄▄█████▓ ██▀███  ▓█████ ";
echo "▒██▀ ██▌▒████▄   ▓  ██▒ ▓▒▒████▄   ▒██▀ ▀█ ▓█   ▀ ██ ▀█   █ ▓  ██▒ ▓▒▓██ ▒ ██▒▓█   ▀ ";
echo "░██   █▌▒██  ▀█▄ ▒ ▓██░ ▒░▒██  ▀█▄ ▒▓█    ▄▒███  ▓██  ▀█ ██▒▒ ▓██░ ▒░▓██ ░▄█ ▒▒███   ";
echo "░▓█▄   ▌░██▄▄▄▄██░ ▓██▓ ░ ░██▄▄▄▄██▒▓▓▄ ▄██▒▓█  ▄▓██▒  ▐▌██▒░ ▓██▓ ░ ▒██▀▀█▄  ▒▓█  ▄ ";
echo "░▒████▓  ▓█   ▓██▒ ▒██▒ ░  ▓█   ▓██▒ ▓███▀ ░▒████▒██░   ▓██░  ▒██▒ ░ ░██▓ ▒██▒░▒████▒";
echo " ▒▒▓  ▒  ▒▒   ▓▒█░ ▒ ░░    ▒▒   ▓▒█░ ░▒ ▒  ░░ ▒░ ░ ▒░   ▒ ▒   ▒ ░░   ░ ▒▓ ░▒▓░░░ ▒░ ░";
echo " ░ ▒  ▒   ▒   ▒▒ ░   ░      ▒   ▒▒ ░ ░  ▒   ░ ░  ░ ░░   ░ ▒░    ░      ░▒ ░ ▒░ ░ ░  ░";
echo " ░ ░  ░   ░   ▒    ░        ░   ▒  ░          ░     ░   ░ ░   ░        ░░   ░    ░   ";
echo "   ░          ░  ░              ░  ░ ░        ░  ░        ░             ░        ░  ░";
echo " ░                                 ░                                                 ";
echo "";

version="1.4.0"

echo "You are running setup version: ${version}";
echo "";
echo "[?] Uptime Ping URL:";
read url
echo "[?] Server Name:";
read server
CodeName="${server,,}"
ServerName="${server^}"
sudo rm /etc/hostname
sudo echo "$ServerName" > /etc/hostname
echo "[+] Modified hostname."
echo "
ip=\`echo \$SSH_CONNECTION | cut -d ' ' -f 1\`
host='${ServerName}'
hostid='${CodeName}'

curl --silent -v \\
-H 'Content-Type: application/json' \\
-X POST \\
-d '{\"username\":\"'\$host'\", \"content\":\"Login from \`'\$ip'\` as \`'\$USER'\` on \`'\$hostid'.senarc\`.    \"}' \\
`cat ./webhook.env` > /dev/null 2>&1
" > /etc/ssh/sshrc
echo "[+] Added SSH notification."
sudo cp ./sudoers /etc/sudoers
echo "[+] Modified sudoers file."
sudo cp ./motd /etc/motd
echo "[+] Updating MOTD message."
sudo chmod 700 /home/*
echo "[-] Restricting Users from accessing other user's folders."
sudo cp ./sshd_config /etc/ssh/sshd_config
echo "[+] Updating sshd service config."
sudo apt update && sudo apt upgrade -y
sudo apt install python3 python3-pip zsh exa git -y
echo "[+] Installed Python3 and Pip."
sudo cp ./heartbeat.service /etc/systemd/system
echo "[+] Added Uptime Service File."
mkdir /root/heartbeat
echo "[+] Created Heartbeat folder."
cp ./worker.py /root/heartbeat
echo "[+] Added Heartbeat python script."
echo "{\"url\": \"$url\"}" > /root/heartbeat/url.json
echo "[+] Added url json file."
python3 -m pip install aiohttp
echo "[+] Installed required packages."
systemctl daemon-reload
echo "[!] Reloaded systemctl daemon."
systemctl start heartbeat
systemctl enable heartbeat
echo "[+] Started Uptime Heartbeat."
echo "[+] Installing ZSH."
echo "[!] Configuring ZSH."
cp -r ./.* ~
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
echo "[!] Changing default shell to zsh."
sudo chsh -s /bin/zsh
chsh -s /bin/zsh
echo "[!] Restarting zsh."
echo "[!] Setup Complete!"

echo "Press 'ENTER' to end script: "
read end

exec zsh