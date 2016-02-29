#!/bin/bash
#author: Gert-Jan Wille

FILES=~/Desktop/Converter/ConvertFiles/*.m4a
EXPORT=~/Desktop/Converter/Export/

COUNTER=0
init(){
	mkdir -p ~/Desktop/Converter/Export/
}

ChangeName (){
	for f in $FILES
		do
			mv "$f" "${f// /_}"
	done
}

FirstConvert (){
	for f in $FILES
		do
			FILENAME=$($f | cut -d / -f 7 <<< $f | rev | cut -c 5- | rev)
			afconvert -f mp4f -d aac -b 128000   $f ${EXPORT}${FILENAME}.mp4

			COUNTER=`expr $COUNTER + 1`

			rm -rf $f
	done
}

if init; then
	if ChangeName; then
		if  FirstConvert; then
			echo ${COUNTER} files converted
		fi
	fi
fi