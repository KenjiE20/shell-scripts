#! /bin/bash

# Path to build playlist in
dir="/home/kenji"
# Playlist file (made in $dir)
pls="playlist.m3u"

# Make sure old tmp isn't there
rm /tmp/vid 2>/dev/null
# Find mpegs
find $dir -type f -iname \*.mpg -print -o -type f -iname \*.mpeg -print > /tmp/vid
# Find Flash
find $dir -type f -iname *.flv -print >> /tmp/vid
find $dir -type f -iname *.iflv -print >> /tmp/vid
# Find Win Media
find $dir -type f -iname *.wmv -print >> /tmp/vid
find $dir -type f -iname *.wmp -print >> /tmp/vid
# Find AVIs
find $dir -type f -iname *.avi -print >> /tmp/vid
# Find MKVs
find $dir -type f -iname *.mkv -print >> /tmp/vid
# Find oggs
find $dir -type f -iname *.ogm -print >> /tmp/vid
find $dir -type f -iname *.ogv -print >> /tmp/vid
# Find mp4s
find $dir -type f -iname \*.mp4 -print -o -type f -iname \*.mp4v -print -o -type f -iname \*.m4v -print -o -type f -iname \*.mp4v -print >> /tmp/vid
find $dir -type f -iname *.hdmov -print >> /tmp/vid
find $dir -type f -iname "*.3gp" -print -o -type f -iname "*.3gpp" -print >> /tmp/vid
# Find divx
find $dir -type f -iname *.divx -print >> /tmp/vid
# Find real
find $dir -type f -iregex ".*\.r.?m" -print >> /tmp/vid

# Sort case insensitive
sort -f /tmp/vid -o /tmp/vid2

# make absolute, relative
quotedir=$( echo $dir | sed 's/\//\\\//g' )
sed 's/^'$quotedir'\///' /tmp/vid2 > /tmp/vid

# Output
echo "#EXTM3U" > $dir/$pls
cat /tmp/vid >> $dir/$pls

# Remove temp
rm /tmp/vid /tmp/vid2
