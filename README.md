# drc02-gg  
 
 
clone the project into the desired working directory;  
<pre>
git clone https://github.com/stm32-hotspot/DRC02_IIoT_GreenGrass_Gateway.git DESIRED_WORKING_DIRECTORY  
cd DESIRED_WORKING_DIRECTORY/projects/drc02-greengrass
</pre>
  
and execute the script found in the DESIRED_WORKING_DIRECTORY/projects/drc02-greengrass folder;  
<pre>
. drc02-greengrass.sh  
</pre>
  
This will create the needed repo as well as retrieve additional required layers.  
  
At the end of this scripts execution you will have the directory structure below;  
<pre>
WORKING_DIRECTORY_NAME  
├── layers  
│   ├── meta-amefae-connectivity      layer for setting up wireless connectivity  
│   └── meta-amefae-greengrass        layer with rules for greengrass inclusion  
└── projects  
    └── drc02-greengrass  
        └── working               Temp directory with the main yocto build checkout  
            ├── downloads         used for many of the build downloads  
            ├── drc02-gg          This is the directory set up by the script as the target of the build  
            └── sources           layers from the platform providers 
</pre>
Anything below "working" can be considered a temporary file.  

Important points to make sure you are aware of
<pre>
- currently using the core-image-minimal target
- the output files can be written to an SD card using the command
    . unxz -c core-image-minimal-dh-stm32mp1-dhcom-drc02.wic.xz | sudo dd of=/dev/SDCARD_DEVICE bs=1M iflag=fullblock oflag=direct conv=fsync status=progress
- By default the boot will use internal storage, you must change this during the boot process
    . power on board, hit a key when the message "Hit any key to stop autoboot:  1" is seen
    . issue the command "env set boot_targets mmc0 mmc1 mmc2 usb pxe" 
    . issue the command "boot"
- currently the default operation of the bluetooth / wifi module is to operate in only Wifi mode
    . in /etc/modprobe.d/rsi_sdio.conf change the mode to 13 to enable bluetooth operation
    . echo "options rsi_sdio dev_oper_mode=13" > /etc/modprobe.d/rsi_sdio.conf
- login as root, no password
</pre>

Steps to run GG IDT
<pre>
- build and write to SD Card
- echo "ggc_user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
- mkdir /home/ggc_user
- chown ggc_user:ggc_group /home/ggc_user
- change password for ggc_user : passwd ggc_user
- modify /etc/passwd : ggc_user:x:996:996::/home/ggc_user:/bin/sh
- from HOST : ssh-keygen -f "/home/user/.ssh/known_hosts" -R "10.0.0.xxx"
- from HOST : ssh-copy-id ggc_user@10.0.0.xxx

- confirm there is a file on the target : /home/ggc_user/.ssh/authorized_keys
- confirm you can ssh to the target : ssh ggc_user@10.0.0.xxx
- confirm sudo privledges
- docker run hello-world
</pre>
