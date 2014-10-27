#sudo xm destroy vm1 && sleep 5 && sudo xm create ../vm-server2_3.9.cfg && sudo xm console vm1
sudo xm create ./vm1-server3.9_$1.cfg
