#! /bin/bash

dir="/media/share"

rm /tmp/vid
rm /tmp/vid2

find $dir -type f -iregex ".*\.mpe?g" -print > /tmp/vid
find $dir -type f -iname *.flv >> /tmp/vid
find $dir -type f -iname *.iflv >> /tmp/vid
find $dir -type f -iname *.wmv >> /tmp/vid
find $dir -type f -iname *.wmp >> /tmp/vid
find $dir -type f -iname *.avi >> /tmp/vid
find $dir -type f -iname *.mka >> /tmp/vid
find $dir -type f -iname *.mkv >> /tmp/vid
find $dir -type f -iname *.ogg >> /tmp/vid
find $dir -type f -iname *.ogm >> /tmp/vid
find $dir -type f -iname *.ogv >> /tmp/vid
find $dir -type f -iregex ".*\.mp?v?4v?" -print >> /tmp/vid
find $dir -type f -iname *.hdmov >> /tmp/vid
find $dir -type f -iregex ".*\.3gpp?" -print >> /tmp/vid
find $dir -type f -iname *.divx >> /tmp/vid
find $dir -type f -iregex ".*\.r.?m" -print >> /tmp/vid

#sleep 1
sort -f /tmp/vid -o /tmp/vid2
