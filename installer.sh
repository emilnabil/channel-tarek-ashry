#!/bin/sh
# ###########################################
# SCRIPT : DOWNLOAD AND INSTALL Channel
# ###########################################
#
# Command: wget https://raw.githubusercontent.com/emilnabil/channel-tarek-ashry/main/installer.sh -qO - | /bin/sh
#
# ###########################################

###########################################
# Configure where we can find things here #
VERSION='2022-08-07'
TMPDIR='/tmp'
PACKAGE='channels_backup_by_tarek-ashry'
MY_URL='https://raw.githubusercontent.com/emilnabil/channel-tarek-ashry/main'

########################
########################
BINPATH=/usr/bin
ETCPATH=/etc
######
BBCPMT=${BINPATH}/bbc_pmt_starter.sh
BBCPY=${BINPATH}/bbc_pmt_v6.py
BBCENIGMA=${BINPATH}/enigma2_pre_start.sh
######
SYSCONF=${ETCPATH}/sysctl.conf
ASTRACONF=${ASTRAPATH}/astra.conf
ABERTISBIN=${ASTRAPATH}/scripts/abertis

########################
CONFIGpmttmp=${TMPDIR}/bbc_pmt_v6/bbc_pmt_starter.sh
CONFIGpytmp=${TMPDIR}/bbc_pmt_v6/bbc_pmt_v6.py
CONFIGentmp=${TMPDIR}/bbc_pmt_v6/enigma2_pre_start.sh
CONFIGsysctltmp=${TMPDIR}/${PACKAGE}/sysctl.conf
CONFIGastratmp=${TMPDIR}/${PACKAGE}/astra.conf
CONFIGabertistmp=${TMPDIR}/${PACKAGE}/abertis

########################
if [ -f /etc/opkg/opkg.conf ]; then
    STATUS='/var/lib/opkg/status'
    OSTYPE='Opensource'
    OPKG='opkg update'
    OPKGINSTAL='opkg install'
fi
echo " remove old channel "
########################
rm -rf /etc/enigma2/lamedb
rm -rf /etc/enigma2/*list
rm -rf /etc/enigma2/*.tv
rm -rf /etc/enigma2/*.radio
rm -rf /etc/tuxbox/*.xml

########################
########################
#########################
rm -rf $ASTRAPATH
rm -f $BINPATH/bbc_pmt_starter.sh
rm -f $BINPATH/bbc_pmt_v6.py
rm -f $BINPATH/enigma2_pre_start.sh
########BINPATH#################
echo
set -e
echo "Downloading And Insalling Channel Please Wait ......"
  wget $MY_URL/${PACKAGE}_${VERSION}.tar.gz -qP $TMPDIR
tar -zxf $TMPDIR/${PACKAGE}_${VERSION}.tar.gz -C /
sleep 4
set +e
echo
echo "   >>>>   Reloading Services - Please Wait   <<<<"
wget -qO - http://127.0.0.1/web/servicelistreload?mode=0 >/dev/null 2>&1
sleep 2
echo
echo "Downloading And Insalling Config BBC Please wait "
wget $MY_URL/bbc_pmt_v6.tar.gz -qP $TMPDIR
wait
tar -xzf /tmp/bbc_pmt_v6.tar.gz -C /
wait
chmod -R 755 $BINPATH/bbc_pmt_starter.sh
chmod -R 755 $BINPATH/bbc_pmt_v6.py
chmod -R 755 $BINPATH/enigma2_pre_start.sh
echo "---------------------------------------------"
if [ $OSTYPE = "Opensource" ]; then
  wget $MY_URL/astra-arm.tar.gz -qP $TMPDIR
 tar -xzf $TMPDIR/astra-arm.tar.gz -C /
 else
 wget $MY_URL/astra-mips.tar.gz -qp 
$TMPDIR
 tar -xzf $TMPDIR/astra-mips.tar.gz -C /
set +e
chmod -R 755 $ASTRAPATH/*
sleep 1;
        echo "---------------------------------------------"
echo "---------------------------------------------"
sleep 2;
echo " tmp cleaner "
cd /tmp
rm -rf * > /dev/null 2>&1
cd ..
echo ""
echo ""
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
    reboot
else
    systemctl restart enigma2
fi

exit 0


























