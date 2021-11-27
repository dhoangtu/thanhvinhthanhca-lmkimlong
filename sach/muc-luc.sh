#!/bin/bash

#set -x

FOLDERS="/d/01.lilypond/01.github/tuyentaphopca-lmkimlong/nhac"
lilypondcmd='lilypond.exe'

export PATH=$PATH:/d/download/qpdf-10.1.0/bin:'/c/Program Files (x86)/LilyPond-2.22.1/usr/bin'

GEN="/d/01.lilypond/01.github/tuyentaphopca-lmkimlong/nhac"
#rm -rf ${GEN}
#mkdir ${GEN}

CONTENT=./muc-luc.csv
rm ${CONTENT}

# create a list of folders to scan for .ly files
IFS=' '
# scan .ly files
pagecounter=1
filelist=()
for fullname in ${FOLDERS}/*.ly
do
    name=`basename -- "$fullname"`
    shortname="${name%.*}"
    
    # lấy tên bài hát
    title=`cat ${fullname} | grep " title" | grep "=" | sed 's/^[^"]*"//g' | sed -e 's/[[:space:]]*$//' | sed 's/\"[[:space:]]//g'`
    # bỏ ký tự cuối
    title=${title%?}
    
    # số trang của file tiếp sau
    pageno=`find ${GEN} -xdev -type f -name "${shortname}.pdf" -exec pdfinfo "{}" ";" | awk '/^Pages:/ {n += $2} END {print n}'`
    echo "${title},${pagecounter}"
    echo "${title},${pagecounter}" >> ${CONTENT}
    pagecounter=$(( $pageno + $pagecounter ))
done
