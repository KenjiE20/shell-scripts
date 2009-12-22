#! /bin/bash

dstamp=$(date +%c)
thum_file="/tmp/thumbs_results"
dsst_file="/tmp/dsstore_results"
dxva_file="/tmp/dxva_results"

echo $dstamp > $thum_file
echo $dstamp > $dsst_file
echo $dstamp > $dxva_file

find /media/scratch/ -path /media/scratch/lost+found -prune -o -writable -type f -name Thumbs.db -print0 | du --files0-from=- -hc >> $thum_file
find /media/scratch/ -path /media/scratch/lost+found -prune -o -writable -type f -name .DS_Store -print0 | du --files0-from=- -hc >> $dsst_file
find /media/scratch/ -path /media/scratch/lost+found -prune -o -writable -type f -name dxva_sig.txt -print0 | du --files0-from=- -hc >> $dxva_file

#find /media/scratch/ -type f -name .DS_Store -exec rm {} \;

#find /media/store/ -writable -type f -name Thumbs.db -print0 | du --files0-from=- -hc >> $thum_file
#find /media/store/ -writable -type f -name .DS_Store -print0 | du --files0-from=- -hc >> $dsst_file
#find /media/store/ -writable -type f -name dxva_sig.txt -print0 | du --files0-from=- -hc >> $dxva_file

#find /media/store/ -type f -name .DS_Store -exec rm {} \;

#find /media/shares/ -writable -type f -name Thumbs.db -print0 | du --files0-from=- -hc >> $thum_file
#find /media/shares/ -writable -type f -name .DS_Store -print0 | du --files0-from=- -hc >> $dsst_file
#find /media/shares/ -writable -type f -name dxva_sig.txt -print0 | du --files0-from=- -hc >> $dxva_file

#find /media/shares/ -type f -name .DS_Store -exec rm {} \;
