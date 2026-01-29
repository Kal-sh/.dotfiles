echo "👉 Copying torrc to /etc/tor/"
sudo cp torrc /etc/tor/torrc

echo "👉 systemctl config for tor"
systemctl enable tor
systemctl restart tor
