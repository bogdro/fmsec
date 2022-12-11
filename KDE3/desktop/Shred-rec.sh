#!/bin/sh
#
# "Safe remove directory (recurse)" Konqueror context menu entry - program.
#
# Copyright (C) 2007,2009 Bogdan 'bogdro' Drozdowski, bogdandr # op . pl
#	[EN] http://miniurl.pl/bogdro-soft
#
# This file may be used only according to the licence of Konqueror itself.
#


if ( test $# -lt 1 ); then

	exit 1;
fi;

RANDOM=`date +%k%d%M%j%S`

IFS=~
echo "$*" | sed 's/~/\n/g' | while read; do directory=$REPLY

	if ( test "x$directory" != "x" ); then

		find "$directory" -type f -exec shred -u '{}' \;

#dirs=`find "$directory" -type d | nl | sort -r | awk '{print $2}'`
#dirs=`find "$directory" -type d | nl | sort -r | sed 's/^\s*//' | tr '\t' ' '	\
#	| cut -d ' ' -f '2-' --output-delimiter=' '`
		dirs=`find "$directory" -type d | nl | sort -r | sed 's/^\s*[0-9]*\s*//'`

		find "$directory" -type d | nl | sort -r | sed 's/^\s*[0-9]*\s*//' | while read; do

			i=$REPLY

			if ( test "x$i" = "x." ); then
				continue;
			fi

			#i=`echo "$i" | sed 's/^\.\///'`
			i=`echo "$i" | perl -wne 's/^\.\///; print;'`

			len=`echo "$i" | wc -c`
			newname=
			for k in `seq 1 25`; do

				newname=
				for j in `seq 1 $len`; do

					#rnd=$(((`printf %d \'A\'` + $RANDOM)%26))
					rnd=$(($RANDOM % 26))
					newname="$rnd$newname"
				done;

				newname="`dirname "$i"`/$newname"
				#newname=`echo "$newname" | sed 's#^\./##'`
				newname=`echo "$newname" | perl -wne 's~^\./~~; print;'`

				mv "$i" "$newname"
				#dirs=`echo "$dirs" | sed "s#\b$i\b#$newname#g"`
				dirs=`echo "$dirs" | perl -wne "s~\b$i\b~$newname~g; print;"`
				i="$newname"
				sync;
			done;
			if ( test "x$newname" != "x" ); then

				rm -fr "$newname"
			fi

		done;	# one directory's loop
	fi # test for empty directory

done;	# all-directory loop

