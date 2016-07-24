#!/bin/sh -x

DIR_PATH='/data/vm/';
usr=$1;
game=$2;

#UUID of SR-disk & vm-template 
sr_temp="5a597059-2ba1-8920-8ef7-72164a8a0505";
vm_temp="345c0d4d-d846-a573-f48e-db84226c6ed7";

DIR_PATH=$DIR_PATH$usr;

#Check whether the user is new or not
if [ ! -e $DIR_PATH ]; then
    /bin/mkdir $DIR_PATH > /tmp/trash;
fi

DIR_PATH=$DIR_PATH"/"$game;
disk_file=$DIR_PATH"/"$usr$game".xva";
uuid_file=$DIR_PATH"/uuid.txt";

#Check the presence of user's past record
if [ ! -e $DIR_PATH ]; then
    /bin/mkdir $DIR_PATH > /tmp/trash;
    /bin/touch $uuid_file;
    #Create a new vm and record the uuid into uuid.txt
    vm_uuid=`/bin/xe vm-copy uuid=$vm_temp new-name-label=$usr$game`;
    /bin/echo $vm_uuid > $uuid_file;
    #Start the vm
    /bin/xe vm-start uuid=$vm_uuid;
else
    #Import the disk image of user's past record
    vm_uuid=`/bin/xe vm-import filename=$disk_file sr-uuid=$sr_temp`;
    /bin/echo $vm_uuid > $uuid_file;
    #Start the vm
    /bin/xe vm-start uuid=$vm_uuid;
fi

exit 0;
