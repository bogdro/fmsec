#!/bin/sh
#
# FMSec KDE5 installer
#
# Copyright (C) 2019-2021 Bogdan 'bogdro' Drozdowski, bogdro (at) users . sourceforge . net
#
# This file is part of FMSec (File Manager SECurity), a set of extensions
#  to file managers.
# FMSec homepage: https://fmsec.sourceforge.io/
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

. common.sh

mkdir -p "$DESTPATH" 2>/dev/null
cp -f desktop/* "$DESTPATH"
unset FILES

if ( test -e "$HOME/bin" && ! test -d "$HOME/bin" ); then

	unset DESTPATH

	echo "$HOME/bin exists, but is not a directory. Fix this. Install partially failed (*.sh scripts not installed)."
	exit 2
fi

[[ ! -e "$HOME/bin" ]] && mkdir "$HOME/bin"

if ( ! test -d "$HOME/bin" ); then

	unset DESTPATH

	echo "$HOME/bin can't be created. Install partially failed."
	exit 3
fi

for i in $SHFILES; do

	[[ ! -e "$HOME/bin/$i" ]] && ln -s "$DESTPATH/$i" "$HOME/bin/$i"
done;

unset DESTPATH

for i in $SHFILES; do

	if (! test -e "$HOME/bin/$i"); then

		unset SHFILES
		echo "Install partially failed: '$HOME/bin/$i' not created."
		exit 4
	fi

done;

unset SHFILES

echo "Install OK. Restart Konqueror/Dolphin/Krusader."
exit 0
