#!/bin/bash

if (cat /etc/ssh/ssh_config|grep "^    PermitRootLogin yes" >NP); then cd .; else  sed -i "$ a \    PermitRootLogin yes" /etc/ssh/sshd_config; fi
if (cat /etc/ssh/ssh_config|grep "^    UsePAM no">NP); then cd .; else  sed -i "$ a \    UsePAM no" /etc/ssh/sshd_config; fi
if (cat ~/.bashrc|grep "^service ssh start">NP); then
  cd .;
  else
    sed -i "$ a \service ssh start" ~/.bashrc
    service ssh start
    echo -e "\e[1;7;31mPlease set your password! \nPlease set your password! \nPlease set your password! \e[0m";
    passwd
fi