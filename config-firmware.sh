#!/bin/bash

source /opt/Xilinx/Vivado/2019.1/settings64.sh
export CROSS_COMPILE=arm-linux-gnueabihf-
export PATH=$PATH:/opt/Xilinx/SDK/2019.1/gnu/aarch32/lin/gcc-arm-linux-gnueabi/bin
export VIVADO_SETTINGS=/opt/Xilinx/Vivado/2019.1/settings64.sh
ABSOLUTE_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)
unset LD_LIBRARY_PATH

# Add this directory only if not already added to avoid problem
# with Buildroot
#export BOARD=$ABSOLUTE_PATH/board
if [ -z "$(echo $BR2_EXTERNAL | grep $ABSOLUTE_PATH)" ]; then
    export BR2_EXTERNAL=$ABSOLUTE_PATH

fi

sudo apt-get install -y git build-essential fakeroot libncurses5-dev libssl-dev ccache
sudo apt-get install -y dfu-util u-boot-tools device-tree-compiler libssl1.0-dev mtools
sudo apt-get install -y bc python cpio zip unzip rsync file wget

cd ..
git clone --recurse-submodules https://github.com/analogdevicesinc/plutosdr-fw.git
cd plutosdr-fw
make clean
cd ..

echo "Build SRT"
rm -rf srt
git clone https://github.com/Haivision/srt.git
cd srt
if [[ ! -d cmake-build ]]
then
	    mkdir cmake-build
fi

cd cmake-build
cmake -DENABLE_ENCRYPTION=OFF -DCMAKE_TOOLCHAIN_FILE=../../datvplutofrm/CmakeArmToolchain.cmake ..
make -j 8
cp srt-live-transmit ../../datvplutofrm/board/pluto/overlay/usr/bin/
cd ../../datvplutofrm

echo "Copy config in place"
cp configs/f5oeo_zynq_pluto_defconfig ../plutosdr-fw/buildroot/configs/f5oeo_zynq_pluto_defconfig

echo "Copy old Make to temp"
mv ../plutosdr-fw/Makefile ../plutosdr-fw/Makefile.orig

echo "Copy new Makefile in place"
cp plutosdr_fw_patch/Makefile ../plutosdr-fw/Makefile

echo "CD"
cd ../plutosdr-fw

echo "Source"
source ../datvplutofrm/sourceme.ggm
#echo "Copy Patch"
#cp ~/datvplutofrm/patches/debian/patches/04-fix-sigstksz.patch ~/plutosdr-fw/buildroot/package/m4/0003-fix-sigstksz.patch
echo "Make"
make -j 16

echo "Done."

