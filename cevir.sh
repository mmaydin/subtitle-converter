#!/bin/bash

# chmod +x /home/user/scripts/cevir.sh
# add alias to .bashrc or .bash_profile for cevir.sh
# alias cevir="/bin/bash /home/user/scripts/cevir.sh"

# Usage 1:
# cd /home/user
# cevir filename

# Usage 2:
# cevir /home/user/filename

DIR=$(pwd)

if [ -z "$1" ]; then
    echo "Please add file"
    exit 0
else
    if [[ $1 = *"/"* ]]; then
        FILE="$1"
    else
        FILE="$DIR/$1"
    fi
fi

FROM_ENCODING="latin1"
TO_ENCODING="UTF-8"
CONVERT=" iconv  -f   $FROM_ENCODING  -t   $TO_ENCODING"
TO_FILE="${FILE%.srt}.utf8.converted.srt"
SWP_FILE="${FILE%.srt}.utf8.converted.swp.srt"
OLD_FILE="${FILE%.srt}.original.srt"

$CONVERT   "$FILE"   >  $TO_FILE

if [ -f $TO_FILE ]; then
    cat $TO_FILE | sed 's/ð/ğ/g; s/ý/ı/g; s/þ/ş/g; s/Ý/İ/g; s/Þ/Ş/g' > $SWP_FILE
    if [ -f $SWP_FILE ]; then
        mv $SWP_FILE $TO_FILE
        mv $FILE $OLD_FILE
        mv $TO_FILE $FILE
    fi
else
    echo "Something went wrong"
fi
