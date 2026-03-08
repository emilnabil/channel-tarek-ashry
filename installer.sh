#!/bin/sh
# ###########################################
# SCRIPT : DOWNLOAD AND INSTALL Channel
# ###########################################
# Command:
# wget https://raw.githubusercontent.com/emilnabil/channel-tarek-ashry/main/installer.sh -qO - | /bin/sh

TMPDIR="/tmp"
PACKAGE="astra-sm"
MY_URL="https://raw.githubusercontent.com/emilnabil/channel-tarek-ashry/main"
VERSION=$(wget "$MY_URL/version" -qO- | cut -d "=" -f2-)

if [ -f /etc/opkg/opkg.conf ]; then
    STATUS="/var/lib/opkg/status"
    OSTYPE="Opensource"
    OPKG="opkg update"
    OPKGINSTAL="opkg install --force-overwrite"
fi

if [ -f /etc/image-version ]; then
    IMAGE_NAME=$(cat /etc/image-version)
elif [ -f /etc/version ]; then
    IMAGE_NAME=$(cat /etc/version)
else
    IMAGE_NAME=$(uname -s)
fi

rm -rf /etc/enigma2/lamedb /etc/enigma2/*.tv /etc/enigma2/*.radio /etc/enigma2/*list

install() {
    if ! grep -qs "Package: $1" "$STATUS"; then
        $OPKG >/dev/null 2>&1
        echo ">> Installing required package: $1"
        $OPKGINSTAL "$1" >/dev/null 2>&1
        sleep 1
    fi
}

if [ "$OSTYPE" = "Opensource" ]; then
    for i in dvbsnoop "$PACKAGE"; do
        install "$i"
    done
fi

echo
echo ">> Downloading and installing channel list..."
wget "$MY_URL/channels_backup_by_tarek-ashry.tar.gz" -qP "$TMPDIR"
tar -zxf "$TMPDIR/channels_backup_by_tarek-ashry.tar.gz" -C /
sleep 5

echo
echo ">> Reloading services..."
wget -qO - http://127.0.0.1/web/servicelistreload?mode=0 >/dev/null 2>&1
sleep 2

rm -rf "$TMPDIR/channels_backup_by_tarek-ashry.tar.gz"
sync
sleep 5
echo
echo "**************************************************"
echo "# Channel and config installed successfully      #"
echo "# Uploaded by >>>> EMIL_NABIL                    #"
echo "# Version: ${VERSION}                            #"
echo "# Image: ${IMAGE_NAME}                           #"
echo "# System type: ${OSTYPE}                         #"
echo "# Your device will restart now                   #"
echo "**************************************************"
sleep 4

if [ "$OSTYPE" = "Opensource" ]; then
    killall -9 enigma2
else
    systemctl restart enigma2
fi

exit 0




