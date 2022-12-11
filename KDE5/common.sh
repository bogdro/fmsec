#!/bin/sh
#
# FMSec KDE5 installer & uninstaller common data.
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

if ( test -z "$HOME" ); then

	if ( test -d "/home/`whoami`" ); then

		HOME=/home/`whoami`
	else
		echo "Set 'HOME' to your home directory and re-run this script."
		exit 1
	fi
fi

DESTPATH="$HOME/.local/share/kservices5"

unalias mkdir >/dev/null 2>&1
unalias cp >/dev/null 2>&1
unalias rm >/dev/null 2>&1

FILES="safeRemoveDir.desktop		\
	safeRemove.desktop		\
	Shred-rec.sh			\
	openssl-decrypt.desktop		\
	Openssl-decrypt.sh		\
	openssl-encrypt.desktop		\
	truecrypt-mount.desktop		\
	truecrypt-umount.desktop	\
	TrueCrypt-mount.sh		\
	veracrypt-mount.desktop		\
	veracrypt-umount.desktop	\
	VeraCrypt-mount.sh		\
	wipefreespace.desktop		\
	"

SHFILES="Shred-rec.sh			\
	Openssl-decrypt.sh		\
	TrueCrypt-mount.sh		\
	VeraCrypt-mount.sh		\
	"
