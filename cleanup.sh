#! /bin/bash

dstamp=$(date +%c) # Get a timestamp

# Space seperated list of paths to clean
paths=(/media/scratch /media/store /media/shares)

# Log files
thum_file="/tmp/thumbs_log"
dsst_file="/tmp/dsstore_log"
dxva_file="/tmp/dxva_log"

# Start a log with the date
echo $dstamp > $thum_file
echo $dstamp > $dsst_file
echo $dstamp > $dxva_file

# For each path
for i in "${paths[@]}" ; do
    # Thumbs.db found
    echo "Files found in $i:" >> $thum_file
    find $i -path $i/lost+found -prune -o -writable -type f -name Thumbs.db -print0 | du --files0-from=- -hc >> $thum_file
    # .DS_Store found
    echo "Files found in $i:" >> $dsst_file
    find $i -path $i/lost+found -prune -o -writable -type f -name .DS_Store -print0 | du --files0-from=- -hc >> $dsst_file
    # dvxa_sig.txt found
    echo "Files found in $i:" >> $dxva_file
    find $i -path $i/lost+found -prune -o -writable -type f -name dxva_sig.txt -print0 | du --files0-from=- -hc >> $dxva_file
done

#find /media/scratch/ -type f -name .DS_Store -exec rm {} \;

#rm $thum_file $dsst_file $dxva_file
