#!/bin/sh
#
# "Mount using VeraCrypt" context menu entry - program.
#
# Copyright (C) 2019-2025 Bogdan Drozdowski, bogdro (at) users . sourceforge . net
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
#  along with this program. If not, see <https://www.gnu.org/licenses/>.
#

if [[ "x$1" = "x" ]]; then

	echo -n "Enter VeraCrypt volume path: "
	read v

	if [[ "x$v" = "x" || ! -e "$v" ]]; then

		exit 1
	fi
else
	v="$1"
fi;

if [[ "x$2" = "x" ]]; then

	echo -n "Enter destination directory: "
	read d

	if [[ "x$d" = "x" || ! -e "$d" ]]; then

		exit 2
	fi
else
	d="$2"
fi;

[[ ! -d "$d" ]] && (mkdir -p "$d" || exit 3)
[[ -d "$d" ]] && veracrypt "$v" "$d"

exit $?
