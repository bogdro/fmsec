#!/bin/sh
#
# "Decrypt using OpenSSL" Konqueror context menu entry - program.
#
# Copyright (C) 2007-2021 Bogdan 'bogdro' Drozdowski, bogdro (at) users . sourceforge . net
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

name=`echo $1 | sed 's/\.enc$//'`

if ( test -f $name ); then

	name="$name.dec"
fi

openssl enc -bf -a -in $1 -d -out $name

