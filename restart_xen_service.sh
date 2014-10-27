sudo xm destroy vm1
sudo ./start.sh
sudo xm create vm-server2_3.9.cfg
sudo xm mem-set 0 8192
sudo xm console vm1
