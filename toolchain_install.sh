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

# http://wiki.openmoko.org/wiki/NeoCon 
# neocon is a handy serial console utility (not only) for U-Boot.
# Usage ./neocon -t 30 /dev/ttyACM0
# to quit neocon type ~.

echo "### Install neocon"
mkdir neocon
cd neocon 
wget http://svn.openmoko.org/developers/werner/neocon/Makefile
wget http://svn.openmoko.org/developers/werner/neocon/README
wget http://svn.openmoko.org/developers/werner/neocon/neocon.c

make

# Build STM32F4 Toolchain
# http://jeremyherbert.net/get/stm32f4_getting_started

echo "### Install STM32F4"

sudo apt-get install git zlib1g-dev libtool flex \
     bison libgmp3-dev libmpfr-dev libncurses5-dev libmpc-dev \
     autoconf texinfo build-essential libftdi-dev

git clone https://github.com/MikeSmith/summon-arm-toolchain.git

cd summon-arm-toolchain
./summon-arm-toolchain

export PATH=$PATH:$HOME/sat/bin

echo "export PATH=\$PATH:\$HOME/sat/bin" >> $HOME/.profile

echo "Check arm-none-eabi-gcc"
arm-none-eabi-gcc --version
