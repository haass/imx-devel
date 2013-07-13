#!/bin/sh
#
ARCH=$(uname -m)

#Dual/Quad Core arms are now more prevalent, so don't just limit to x86:
CORES=$(cat /proc/cpuinfo | grep processor | wc -l)

unset GIT_OPTS
unset GIT_NOEDIT
LC_ALL=C git help pull | grep -m 1 -e "--no-edit" >/dev/null 2>&1 && GIT_NOEDIT=1

if [ "${GIT_NOEDIT}" ] ; then
	GIT_OPTS="${GIT_OPTS} --no-edit"
fi

#TI's SGX, etc...
#need_32bit_libs="enable"

config="imx_v6_v7_defconfig"

#linaro_toolchain="arm9_gcc_4_7"
#linaro_toolchain="cortex_gcc_4_6"
linaro_toolchain="cortex_gcc_4_7"
#linaro_toolchain="cortex_gcc_4_8"

#Kernel/Build
KERNEL_REL=3.9
KERNEL_TAG=${KERNEL_REL}.9
BUILD=imx5

#v3.X-rcX + upto SHA
#KERNEL_SHA=""

#git branch
BRANCH="v3.9.x-imx"

BUILDREV=1.0
DISTRO=cross
DEBARCH=armhf
