#!/usr/bin/python

import sys, re, zlib

c_null="\033[0;00m"
c_red="\033[;31m"
c_green="\033[;32m"

def crc32_checksum(filename):
    filedata = open(filename, "rb").read()
    sum = zlib.crc32(filedata)
    if sum < 0:
        sum &= 16**8-1
    return "%.8X" %(sum)

for file in sys.argv[1:]:
    sum = crc32_checksum(file)
    try:
        dest_sum = re.split('[\[\]]', file)[-2]
        dest_sum = re.search('[\[(][\dA-F]{8}[\])]', file).group()[1:-1]
        if sum == dest_sum:
            c_in = c_green
        else:
            c_in = c_red
        sfile = file.split(dest_sum)
        print "%s%s%s   %s%s%s%s%s" % (c_in, sum, c_null, sfile[0], c_in, dest_sum, c_null, sfile[1])
    except IndexError:
        print "%s   %s" %(sum, file)
