#!/bin/bash

unset BUILD

KERNEL_REL=2.6.35

#for x.x.X
STABLE_PATCH=3

#for x.x-gitX
#PRE_SNAP=v2.6
#PRE_RC=2.6.38-git20

#for x.x-rcX
#RC_KERNEL=2.6.39
#RC_PATCH=-rc1

ABI=1

BUILD=imx${ABI}

BUILDREV=1.0
DISTRO=cross

export KERNEL_REL BUILD RC_PATCH KERNEL_PATCH
export BRANCH REL
export BUILDREV DISTRO
