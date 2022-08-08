#!/bin/sh # 
 # # Command: wget https://raw.githubusercontent.com/emilnabil/channel-tarek-ashry/main/installer.sh -qO - | /bin/sh # # ########################################### ###########################################
VERSION="2022-08-07"  
MY_URL="https://raw.githubusercontent.com/emilnabil/channel-tarek-ashry/main"  
echo "******************************************************************************************************************"
echo "    download and install channel  "
echo "============================================================================================================================="
echo " remove old channel "
# Remove any Channel  # 
rm -rf /etc/enigma2/lamedb 
rm -rf /etc/enigma2/*list 
rm -rf /etc/enigma2/*.tv 
rm -rf /etc/enigma2/*.radio 
rm -rf /etc/tuxbox/*.xml 
#####################################################################################
echo "         install channel    "
cd /tmp
set -e 
wget -q  "https://raw.githubusercontent.com/emilnabil/channel-tarek-ashry/main/channels_backup_by_tarek-ashry_2022-08-07.tar.gz"
wait
tar -xzf channels_backup_by_tarek-ashry_2022-08-07.tar.gz  -C /
wait
echo "   >>>>   Reloading Services - Please Wait   <<<<"
wget -qO - http://127.0.0.1/web/servicelistreload?mode=0 >/dev/null 2>&1
sleep 2
cd ..
set +e
rm -f /tmp/channels_backup_by_tarek-ashry_2022-08-07.tar.gz
sleep 2;
echo "" 
echo "Installing astra sm patch - dvbsnoop "
opkg install astra-sm 
opkg install dvbsnoop
sleep 1
cd /tmp
set -e
wget
"https://raw.githubusercontent.com/emilnabil/channel-tarek-ashry/main/astra-arm.tar.gz"
wait
tar -xzf astra-arm.tar.gz  -C /
wait
cd ..
set +e
rm -f /tmp/astra-arm.tar.gz
rm /etc/astra/astra.conf
wait
wget https://raw.githubusercontent.com/ciefp/astra.conf/main/astra.conf -P /etc/astra/ && chmod 755 /etc/astra/astra.conf
chmod 755 /etc/astra/scripts/abertis
sleep 1
cd /tmp
set -e
wget
"wget https://raw.githubusercontent.com/emilnabil/channel-tarek-ashry/main/bbc_pmt_v6.tar.gz"
wait
tar -xzf bbc_pmt_v6.tar.gz  -C /
wait
cd ..
set +e
rm -f /tmp/bbc_pmt_v6.tar.gz
sleep 1

 wait   
echo ""
echo ""
echo "" 
echo "****************************************************************************************************************************"
echo "*********************************************************"
echo "#       Channel And Config INSTALLED SUCCESSFULLY       #"
echo "   UPLOADED BY  >>>>   EMIL_NABIL "   
sleep 4;
	echo '========================================================================================================================='
echo "#                    ${VERSION}                         #"                 
echo "*********************************************************"
echo "#           your Device will RESTART Now                #"
echo "*********************************************************"
sleep 2

if [ $OSTYPE = "Opensource" ]; then
    init 6
else
    systemctl restart enigma2
fi

exit 0
























