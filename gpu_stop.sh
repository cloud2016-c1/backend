#!/bin/sh -x

DIR_PATH='/data/vm';

usr=$1;
game=$2;

DIR_PATH=$DIR_PATH"/"$usr"/"$game;
disk_file=$DIR_PATH"/"$usr$game".xva";
uuid_file=$DIR_PATH"/uuid.txt";

#check existence of the requested user & game
if [ ! -e $DIR_PATH ]; then
    /bin/The game is not ;
else
    #shutdown vm with uuid based on uuid.txt 
    uuid=`/bin/cat $uuid_file`;
    /bin/echo $uuid;
    /bin/xe vm-shutdown uuid=$uuid force=true;
    #export disk image of the machine
    /bin/xe vm-export uuid=$uuid filename=$disk_file;
    #destroy the machine
    /bin/xe vm-destroy uuid=$uuid;
fi
exit 0;
running.echo 
