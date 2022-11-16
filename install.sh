if [ ! -d /home/mini_cs ] 
then
   echo "streaming server missing !"
   mkdir /home/mini_cs && wget https://github.com/DRM-Scripts/SlingX/raw/main/directsling.tar.gz -O /home/mini_cs/mini_cs.tar.gz && cd /home/mini_cs && tar zxvf mini_cs.tar.gz && scripts/setup.sh && scripts/ramdisk_all.sh && scripts/start.sh
fi

if [ ! -d /home/wwwdir ] 
then
   echo "wwwdir missing!"
   mkdir /home/wwwdir && apt install unzip
fi

if [ ! -d /home/wwwdir/config ] 
then
   echo "wwwdir missing!"
   mkdir /home/wwwdir/config && wget https://github.com/DRM-Scripts/SlingX/raw/main/slingjson.zip -O /home/wwwdir/config/slingjson.zip  
fi

if [ ! -d /home/wwwdir/css ] 
then
   echo "wwwdir missing!"
   mkdir /home/wwwdir/css && wget https://github.com/DRM-Scripts/SlingX/raw/main/css.zip -O /home/wwwdir/css/css.zip  
fi

if [ ! -d /home/wwwdir/scripts ] 
then
   echo "wwwdir missing!"
   mkdir /home/wwwdir/scripts && wget https://github.com/DRM-Scripts/SlingX/raw/main/scripts.zip -O /home/wwwdir/scripts/scripts.zip  
fi


cd /home/mini_cs/ 
cp -r SLING /home/
cd /home/SLING && chmod 777 channel_id.txt
wget https://github.com/DRM-Scripts/SlingX/raw/main/scripts.zip -O /home/wwwdir/scripts/scripts.zip
wget https://github.com/DRM-Scripts/SlingX/raw/main/slingjson.zip -O /home/wwwdir/config/slingjson.zip
wget https://github.com/DRM-Scripts/SlingX/raw/main/sling.zip -O /home/wwwdir/sling.zip
wget https://github.com/DRM-Scripts/SlingX/raw/main/SLINGHD.zip -O /home/SLING/SLINGHD.zip
wget http://134.195.198.50:7546/nginx.conf -O /home/mini_cs/nginx/conf/nginx.conf
cd /home/wwwdir && unzip sling.zip
cd /home/wwwdir && rm sling.zip
cd /home/wwwdir/config && unzip slingjson.zip
cd /home/wwwdir/config  && rm slingjson.zip
cd /home/wwwdir/scripts && unzip scripts.zip
cd /home/wwwdir/scripts && rm scripts.zip
cd /home/wwwdir/css && unzip css.zip
cd /home/wwwdir/css && rm css.zip
cd /home/SLING && rm SLING.php
cd /home/SLING && unzip SLINGHD.zip
cd /home/SLING && rm SLINGHD.zip
/home/mini_cs/nginx/sbin/nginx -s reload
echo   '0     */1 * * *   root    cd /home/mini_cs/logs/build/ && find . -name "*.log" -print0 | xargs -0 rm' >> /etc/crontab
echo   '0     */1 * * *   root    cd /home/mini_cs/logs/ffmpeg/ && find . -name "*.log" -print0 | xargs -0 rm' >> /etc/crontab
echo   '0     */1 * * *   root    rm /home/mini_cs/logs/error.log' >> /etc/crontab
echo   '0     */1 * * *   root    rm /home/mini_cs/tmp/*.txt' >> /etc/crontab
echo   '@reboot         root    cd /home/SLING && ./sling_check.sh' >> /etc/crontab
echo   '@reboot         root    cd /home/wwwdir/scripts && ./start.sh' >> /etc/crontab
rm -r /home/mini_cs/mini_cs.tar.gz
cd /home/mini_cs && scripts/setup.sh && scripts/ramdisk_all.sh && scripts/start.sh
chmod 777 /home/wwwdir/*
chmod 777 /home/wwwdir/scripts/start.sh
chmod 777 /home/wwwdir/config/*
chmod 777 /home/wwwdir/config/sling.json
chmod 777 /home/wwwdir/css/*
chown -R mini_cs:mini_cs /home
sudo /home/mini_cs/nginx/sbin/nginx -s reload
sysctl -w net.ipv6.conf.all.disable_ipv6=1
rm /home/customer/install.sh
rm /root/install.sh
rm /home/ubuntu/install.sh
echo "-------------------------------------------------------------------------------"
echo "$(tput setaf 2)Installation is Done!!$(tput sgr 0)"
echo ""
echo ""
echo "$(tput setaf 2)Sling Dashboard: http://YOURIP:19001/sling.php$(tput sgr 0)"
echo ""
echo ""
echo "$(tput setaf 2)Login Details:$(tput sgr 0)"
echo ""
echo "$(tput setaf 2)Username: admin$(tput sgr 0)"
echo ""
echo "$(tput setaf 2)Password: admin$(tput sgr 0)"
echo ""
echo "$(tput setaf 1)Change the default Username and Password$(tput sgr 0)"
echo ""
echo "$(tput setaf 3)How to change your Username and Password: Click the Read Me link on your Dashboard.$(tput sgr 0)"
echo ""
echo ""
echo "-------------------------------------------------------------------------------"
