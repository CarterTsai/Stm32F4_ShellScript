#!/bin/bash 
#
# Develop for STM32F4-Discovery and 
# OS is Ubuntu
# Author : Carter Tsai
 

sudo apt-get install automake* libtool libusb-1.0-0-dev

echo "### Get Stlink"
git clone http://github.com/texane/stlink.git

cd stlink 
echo "### Install Stlink"
./autogen.sh
./configure --prefix=/opt/arm/
make
sudo make install
sudo cp 49-stlinkv2.rules /etc/udev/rules.d/


echo "### Get OpenOCD"
git clone git://openocd.git.sourceforge.net/gitroot/openocd/openocd

cd openocd
echo "### Install OpenOCD"
./bootstrap
./configure \
    --prefix=/opt/openocd \
    --enable-jlink \
    --enable-amtjtagaccel \
    --enable-buspirate \
    --enable-stlink \
    --disable-libftdi

echo -e "all:\ninstall:" > doc/Makefile
make 
sudo make install 
