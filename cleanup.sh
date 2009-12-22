#! /bin/bash

dstamp=$(date +%c)

paths=(/media/scratch /media/store /media/shares)

thum_file="/tmp/thumbs_log"
dsst_file="/tmp/dsstore_log"
dxva_file="/tmp/dxva_log"

echo $dstamp > $thum_file
echo $dstamp > $dsst_file
echo $dstamp > $dxva_file

for i in "${paths[@]}" ; do
    echo "Files found in $i:" >> $thum_file
    find $i -path $i/lost+found -prune -o -writable -type f -name Thumbs.db -print0 | du --files0-from=- -hc >> $thum_file
    echo "Files found in $i:" >> $dsst_file
    find $i -path $i/lost+found -prune -o -writable -type f -name .DS_Store -print0 | du --files0-from=- -hc >> $dsst_file
    echo "Files found in $i:" >> $dxva_file
    find $i -path $i/lost+found -prune -o -writable -type f -name dxva_sig.txt -print0 | du --files0-from=- -hc >> $dxva_file
done

#find /media/scratch/ -type f -name .DS_Store -exec rm {} \;

#rm $thum_file $dsst_file $dxva_file
