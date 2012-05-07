#!/bin/bash

unset BUILD

#KERNEL_REL=3.3

#for x.x.X
#STABLE_PATCH=7

#for x.x-rcX
RC_KERNEL=3.4
RC_PATCH=-rc6

ABI=0

BUILD=imx${ABI}

BUILDREV=1.0
DISTRO=cross
DEBARCH=armel

export KERNEL_REL STABLE_PATCH RC_KERNEL RC_PATCH BUILD
export BUILDREV DISTRO DEBARCH ABI
