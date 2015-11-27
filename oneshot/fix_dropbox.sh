#!/bin/bash
IFS=$(echo -en "\n\b")
d1="$HOME/Dropbox/Camera Uploads"
d2="$HOME/Dropbox/pics"
for f1 in `ls -1 "$d1"`; do
	f2=`find "$d2" -name "$f1"`
	if [ "$f2" ]; then
		# difference in file sizes (negative means file in Camera\ Uploads is short)
		diff=$(echo $(wc -l "$d1/$f1" | awk '{print $1}' | tr -d '\n')-$(wc -l "$f2" | awk '{print $1}' | tr -d '\n') | bc)
		echo $diff
		#cmp "$d1/$f1" "$f2"
		#rm -f "$d1/$f1"
	fi
done

