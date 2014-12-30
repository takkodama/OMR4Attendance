#!/bin/bash

if [ $# -ne 2 ];then
echo “Usage: $0 target.pdf outfile”
exit
fi

TARGET=$1
OUTFILE=$2

gs \
-dSAFER \
-dBATCH \
-dNOPAUSE \
-dMaxStripSize=8192 \
-sDEVICE=jpeg \
-r600 \
-sOutputFile=rsc/${OUTFILE}-%d.jpg \
${TARGET}