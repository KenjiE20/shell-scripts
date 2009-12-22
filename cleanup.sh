#! /bin/bash

dstamp=$(date +%c) # Get a timestamp

# Space seperated list of paths to clean
paths=(/media/scratch /media/store /media/shares)

# Log files
thum_file="/tmp/thumbs_log"
dsst_file="/tmp/dsstore_log"
dxva_file="/tmp/dxva_log"

# Start a log with the date
echo "Started: $dstamp" > $thum_file
echo "Started: $dstamp" > $dsst_file
echo "Started: $dstamp" > $dxva_file

# For each path
for i in "${paths[@]}" ; do
    # Find Thumbs.db
    echo "Finding Thumbs.db files in $i:" >> $thum_file
    # Find files and du
    find $i -path $i/lost+found -prune -o -writable -type f -name Thumbs.db -print0 | du --files0-from=- -hc >> $thum_file
    # Remove files
    echo "Removing Thumbs.db files in $i:" >> $thum_file
    find $i -path $i/lost+found -prune -o -writable -type f -name Thumbs.db -exec rm -v {} \; >> $thum_file

    # Find .DS_Store
    echo "Finding .DS_Store files in $i:" >> $dsst_file
    # Find files and du
    find $i -path $i/lost+found -prune -o -writable -type f -name .DS_Store -print0 | du --files0-from=- -hc >> $dsst_file
    # Remove files
    echo "Removing .DS_Store files in $i:" >> $dsst_file
    find $i -path $i/lost+found -prune -o -writable -type f -name .DS_Store -exec rm -v {} \; >> $dsst_file

    # Find dvxa_sig.txt
    echo "Finding dxva_sig.txt files in $i:" >> $dxva_file
    # Find files and du
    find $i -path $i/lost+found -prune -o -writable -type f -name dxva_sig.txt -print0 | du --files0-from=- -hc >> $dxva_file
    # Remove files
    echo "Removing dxva_sig.txt files in $i:" >> $dxva_file
    find $i -path $i/lost+found -prune -o -writable -type f -name dxva_sig.txt -exec rm -v {} \; >> $dxva_file
done

dstamp2=$(date +%c) # Get a timestamp

# Finish a log with the date
echo "Finished at: $dstamp2" >> $thum_file
echo "Finished at: $dstamp2" >> $dsst_file
echo "Finished at: $dstamp2" >> $dxva_file

# Email the logs
cat $thum_file | mail -s "Thumbs.db cleanup" kenji@localhost
cat $dsst_file | mail -s ".DS_Store cleanup" kenji@localhost
cat $dxva_file | mail -s "dxva_sig.txt cleanup" kenji@localhost

# Remove temp logs
rm $thum_file $dsst_file $dxva_file
