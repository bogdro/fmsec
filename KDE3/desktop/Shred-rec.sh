#!/bin/sh
#
# "Safe remove directory (recurse)" Konqueror context menu entry - program.
#
# Copyright (C) 2007 Bogdan 'bogdro' Drozdowski, bogdro (at) users . sourceforge . net
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either version 2
#  of the License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software Foudation:
# 		Free Software Foundation
# 		51 Franklin Street, Fifth Floor
# 		Boston, MA 02110-1301
# 		USA
#


if ( test "x$1" = "x" ); then

	exit 1;
fi;

find $1 -type f -exec shred -u '{}' \;

dirs=`find $1 -type d | nl | sort -r | awk '{print $2}'`

RANDOM=`date +%k%d%M%j%S`

for i in $dirs; do

	if ( test "x$i" = "x." ); then
		continue;
	fi;

	i=`echo $i | sed "s#^\./##"`

	len=`echo $i | wc -c`
	for k in `seq 1 25`; do

		newname=
		for j in `seq 1 $len`; do

			rnd=$((`printf %d \'A\'` + (k + $RANDOM)%26))
			newname="$rnd$newname"
		done;

		newname=`dirname $i`/$newname
		newname=`echo $newname | sed 's#^\./##'`
		mv $i $newname
		dirs=`echo $dirs | sed "s#\b$i\b#$newname#g"`
		i=$newname
		sync;
	done;
done;

rm -fr $newname

