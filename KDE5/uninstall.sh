#!/bin/sh
#
# FMSec KDE5 uninstaller
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

for i in $FILES; do
	rm -f "$DESTPATH/$i"
done;

unset DESTPATH
unset i
unset FILES

for i in $SHFILES; do

	[[ -L "$HOME/bin/$i" ]] && rm -f "$HOME/bin/$i"
done;

unset SHFILES

echo "Uninstall OK. Restart Konqueror/Dolphin/Krusader."
exit 0