#!/bin/bash

set -x

FOLDERS="/d/01.lilypond/01.github/tuyentaphopca-lmkimlong/nhac"
lilypondcmd='lilypond.exe'

export PATH=$PATH:/d/download/qpdf-10.1.0/bin:'/c/Program Files (x86)/LilyPond-2.22.1/usr/bin'

GEN=./pdf-generated
rm -rf ${GEN}
mkdir ${GEN}

CONTENT=./content-table.csv
rm ${CONTENT}

# create a list of folders to scan for .ly files
IFS=' '
# scan .ly files
pagecounter=1
filelist=()
for fullname in ${FOLDERS}/*.ly
do
    echo "=== Generating $fullname "
    name=`basename -- "$fullname"`
    shortname="${name%.*}"
    
    # get title
    title=`cat ${fullname} | grep " title" | grep "=" | sed 's/^[^"]*"//g' | sed -e 's/[[:space:]]*$//' | sed 's/\"[[:space:]]//g'`
    # remove last character
    title=${title%?}
    #echo "title: ${title}"

    # generate pdf files
    ${lilypondcmd} --output="${GEN}/${shortname}" -dno-point-and-click --pdf "$fullname"
    
    #page counter
    echo "${title};${pagecounter}" >> ${CONTENT}
    # starting page of next song
    pageno=`find . -xdev -type f -name "${GEN}/${shortname}.pdf" -exec pdfinfo "{}" ";" | awk '/^Pages:/ {n += $2} END {print n}'`
    echo "${title} : ${pageno} pages"
    pagecounter=$(( $pageno + $pagecounter ))
	
	filelist+=( "${GEN}/${shortname}.pdf" )
    
    echo "" 
done

qpdf --empty --pages "${filelist[@]}" -- nhac.pdf

pdflatex so-trang-chan-le.tex

qpdf --empty --pages  bia-truoc.pdf blank-a4.pdf so-trang-chan-le.pdf bia-sau-trong.pdf -- tuyentaphopca-lmkimlong.pdf

rm -rf ${GEN} so-trang-chan-le.pdf nhac.pdf *.aux *.log
