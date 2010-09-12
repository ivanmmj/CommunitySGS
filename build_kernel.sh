#/bin/bash

Vibrant() {
		HW_BOARD_REV=t959
		HW_BOARD_REV=05
}

Captivate() {
		HW_BOARD_REV=kepler
		HW_BOARD_REV=03

}



echo "$1 $2 $3"

case "$1" in
	Clean)
		echo "********************************************************************************"
		echo "* Clean Kernel                                                                 *"
		echo "********************************************************************************"

		pushd linux-2.6.29
		make clean
		popd
		pushd modules
		make clean
		popd
		echo " It's done... "
		exit
		;;
	*)


device=`zenity --title "Choose your device" --text "Please select your device from the following list." --height 380 --width 250 --list --radiolist --column "" --column "    Please Select An Option" True "Vibrant" False "Captivate"`
		case $device in
		 	"Vibrant")Vibrant;;
		 	"Captivate")Captivate;;
		esac

		;;
esac

if [ "$CPU_JOB_NUM" = "" ] ; then
	CPU_JOB_NUM=8
fi

TOOLCHAIN=../arm-none-eabi-4.3.4/bin
TOOLCHAIN_PREFIX=arm-none-eabi-

KERNEL_BUILD_DIR=linux-2.6.29

export PRJROOT=$PWD
export PROJECT_NAME
export HW_BOARD_REV

export LD_LIBRARY_PATH=.:${TOOLCHAIN}/../lib

echo "************************************************************"
echo "* EXPORT VARIABLE		                            	 *"
echo "************************************************************"
echo "PRJROOT=$PRJROOT"
echo "PROJECT_NAME=$PROJECT_NAME"
echo "HW_BOARD_REV=$HW_BOARD_REV"
echo "************************************************************"

BUILD_MODULE()
{
	echo "************************************************************"
	echo "* BUILD_MODULE	                                       	 *"
	echo "************************************************************"
	echo

	pushd modules

		make ARCH=arm CROSS_COMPILE=$TOOLCHAIN/$TOOLCHAIN_PREFIX

	popd
}

BUILD_KERNEL()
{
	echo "************************************************************"
	echo "*        BUILD_KERNEL                                      *"
	echo "************************************************************"
	echo


	pushd $KERNEL_BUILD_DIR

	export KDIR=`pwd`

	make ARCH=arm $PROJECT_NAME"_rev"$HW_BOARD_REV"_defconfig"

	# make kernel
	make -j$CPU_JOB_NUM HOSTCFLAGS="-g -O2" ARCH=arm CROSS_COMPILE=$TOOLCHAIN/$TOOLCHAIN_PREFIX

	popd
	
	BUILD_MODULE
}

# print title
PRINT_USAGE()
{
	echo "************************************************************"
	echo "* PLEASE TRY AGAIN                                         *"
	echo "************************************************************"
	echo
}

PRINT_TITLE()
{
	echo
	echo "************************************************************"
	echo "*                     MAKE PACKAGES"
	echo "************************************************************"
	echo "* 1. kernel : zImage"
	echo "* 2. modules"
	echo "************************************************************"
}

##############################################################
#                   MAIN FUNCTION                            #
##############################################################
if [ $# -gt 3 ]
then
	echo
	echo "**************************************************************"
	echo "*  Option Error                                              *"
	PRINT_USAGE
	exit 1
fi

START_TIME=`date +%s`

PRINT_TITLE

BUILD_KERNEL
END_TIME=`date +%s`
let "ELAPSED_TIME=$END_TIME-$START_TIME"
echo "Total compile time is $ELAPSED_TIME seconds"

