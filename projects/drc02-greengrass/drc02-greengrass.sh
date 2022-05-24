
# Copyright (c) 2022 STMicroelectronics.
# All rights reserved.
#
# This software is licensed under terms that can be found in the LICENSE file
# in the root directory of this software component.
# If no LICENSE file comes with this software, it is provided AS-IS.


mkdir working
cd working
repo init -u https://github.com/dh-electronics/dhcom_stm32mp1-bsp-platform -b dunfell 
repo sync

cd sources
git clone -b dunfell https://github.com/aws/meta-aws.git meta-aws
git clone -b dunfell git@github.com:lgirdk/meta-virtualization.git

cd ..

echo "the DHE distribution is in the working folder"
echo "set up the build with the following command"
echo "MACHINE=dh-stm32mp1-dhcom-drc02 DISTRO=dhlinux source ./setup-environment <BUILD_DIR>"
echo "where <BUILD_DIR> is your desired build directory"

MACHINE=dh-stm32mp1-dhcom-drc02 DISTRO=dhlinux source ./setup-environment drc02-gg
bitbake-layers add-layer ../../../../layers/meta-amefae-connectivity
bitbake-layers add-layer ../../../../layers/meta-amefae-greengrass
bitbake-layers add-layer ../sources/meta-openembedded/meta-networking
bitbake-layers add-layer ../sources/meta-openembedded/meta-filesystems
bitbake-layers add-layer ../sources/meta-aws
bitbake-layers add-layer ../sources/meta-virtualization
alias ls="ls --color"


