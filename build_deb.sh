#!/bin/bash -e
#
# Copyright (c) 2009-2012 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

unset KERNEL_REL
unset STABLE_PATCH
unset RC_PATCH
unset BUILD
unset CC
unset LINUX_GIT
unset BISECT
unset LATEST_GIT

unset LOCAL_PATCH_DIR

ARCH=$(uname -m)
CCACHE=ccache

DIR=$PWD

CORES=1
if test "-$ARCH-" = "-x86_64-" || test "-$ARCH-" = "-i686-"
then
 CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
 let CORES=$CORES+1
fi

mkdir -p ${DIR}/deploy/

function git_remote_add {
        #For some reason after 2.6.36-rc3 linux-2.6-stable hasn't been updated...
        git remote add -t torvalds torvalds_remote git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --tags torvalds_remote master
}

function git_kernel {
if [[ -a ${LINUX_GIT}/.git/config ]]; then
  cd ${LINUX_GIT}/
  git fetch
  cd -

  if [[ ! -a ${DIR}/KERNEL ]]; then
    git clone --shared ${LINUX_GIT} ${DIR}/KERNEL
  fi

  cd ${DIR}/KERNEL

  git reset --hard
  git fetch
  git checkout master
  git pull

  git remote | grep torvalds_remote && git fetch --tags torvalds_remote master

  if [ "${RC_PATCH}" ]; then
    git tag | grep v${RC_KERNEL}${RC_PATCH} || git_remote_add
    git branch -D v${RC_KERNEL}${RC_PATCH}-${BUILD} || true
    if [ ! "${LATEST_GIT}" ] ; then
      git checkout v${RC_KERNEL}${RC_PATCH} -b v${RC_KERNEL}${RC_PATCH}-${BUILD}
    else
      git checkout origin/master -b v${RC_KERNEL}${RC_PATCH}-${BUILD}
    fi
  elif [ "${STABLE_PATCH}" ] ; then
    git branch -D v${KERNEL_REL}.${STABLE_PATCH}-${BUILD} || true
    if [ ! "${LATEST_GIT}" ] ; then
      git checkout v${KERNEL_REL}.${STABLE_PATCH} -b v${KERNEL_REL}.${STABLE_PATCH}-${BUILD}
    else
      git checkout origin/master -b v${KERNEL_REL}.${STABLE_PATCH}-${BUILD}
    fi
  else
    git branch -D v${KERNEL_REL}-${BUILD} || true
    if [ ! "${LATEST_GIT}" ] ; then
      git checkout v${KERNEL_REL} -b v${KERNEL_REL}-${BUILD}
    else
      git checkout origin/master -b v${KERNEL_REL}-${BUILD}
    fi
  fi

  git describe

  cd ${DIR}/
else
  echo ""
  echo "ERROR: LINUX_GIT variable in system.sh seems invalid, i'm not finding a valid git tree..."
  echo ""
  echo "Quick Fix:"
  echo "example: cd ~/"
  echo "example: git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git"
  echo "example: Set: LINUX_GIT=~/linux-stable/ in system.sh"
  echo ""
  exit
fi
}

function git_bisect {
        cd ${DIR}/KERNEL

        git bisect start
        git bisect bad v2.6.35-rc2
        git bisect good v2.6.35-rc1
#        git bisect good <>

read -p "bisect look good... (y/n)? "
[ "$REPLY" == "y" ] || exit

        cd ${DIR}/
}

function patch_kernel {
        cd ${DIR}/KERNEL
        export DIR BISECT
        /bin/bash -e ${DIR}/patch.sh || { git add . ; exit 1 ; }

        git add .
        if [ "${RC_PATCH}" ]; then
                git commit -a -m ''$RC_KERNEL''$RC_PATCH'-'$BUILD' patchset' || true
        else if [ "${STABLE_PATCH}" ] ; then
                git commit -a -m ''$KERNEL_REL'.'$STABLE_PATCH'-'$BUILD' patchset' || true
        else
                git commit -a -m ''$KERNEL_REL'-'$BUILD' patchset' || true
        fi
        fi
        fi
#Testing patch.sh patches
#exit
        if [ "${LOCAL_PATCH_DIR}" ]; then
                for i in ${LOCAL_PATCH_DIR}/*.patch ; do patch  -s -p1 < $i ; done
                BUILD+='+'
        fi
#exit
        cd ${DIR}/
}

function copy_defconfig {
	cd ${DIR}/KERNEL/
	make ARCH=arm CROSS_COMPILE=${CC} distclean
	cp ${DIR}/patches/defconfig .config
	cd ${DIR}/
}

function make_menuconfig {
	cd ${DIR}/KERNEL/
	make ARCH=arm CROSS_COMPILE=${CC} menuconfig
	cp .config ${DIR}/patches/defconfig
	cd ${DIR}/
}

function make_deb {
	cd ${DIR}/KERNEL/
	echo "make -j${CORES} ARCH=arm KBUILD_DEBARCH=armel LOCALVERSION=-${BUILD} CROSS_COMPILE="${CCACHE} ${CC}" KDEB_PKGVERSION=${BUILDREV}${DISTRO} deb-pkg"
	time fakeroot make -j${CORES} ARCH=arm KBUILD_DEBARCH=armel LOCALVERSION=-${BUILD} CROSS_COMPILE="${CCACHE} ${CC}" KDEB_PKGVERSION=${BUILDREV}${DISTRO} deb-pkg
	mv ${DIR}/*.deb ${DIR}/deploy/
	cd ${DIR}
}

	/bin/bash -e ${DIR}/tools/host_det.sh || { exit 1 ; }
if [ -e ${DIR}/system.sh ]; then
	. system.sh
	. version.sh
if [ "${LATEST_GIT}" ] ; then
	echo ""
	echo "Warning LATEST_GIT is enabled from system.sh i hope you know what your doing.."
	echo ""
fi

	echo ""
	echo "Building for Debian Squeeze/Wheezy/Sid & Ubuntu 10.04/10.10/11.04/11.10"
	echo ""

	git_kernel
	#git_bisect
	patch_kernel
	copy_defconfig
	#make_menuconfig
	make_deb
else
	echo "Missing system.sh, please copy system.sh.sample to system.sh and edit as needed"
	echo "cp system.sh.sample system.sh"
	echo "gedit system.sh"
fi

