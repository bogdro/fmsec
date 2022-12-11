#!/bin/sh
#
# FMSec KDE3 uninstaller
#
# Copyright (C) 2007-2021 Bogdan 'bogdro' Drozdowski, bogdro (at) users . sourceforge . net
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

if ( test -z "$KDEHOME" ); then

	if ( test -d "$HOME/.kde" ); then

		KDEHOME=$HOME/.kde
	else
		echo "Set KDEHOME to your home KDE directory and re-run this script."
		exit 2
	fi
fi

DESTPATH="$KDEHOME/share/apps/konqueror/servicemenus"

unalias rm >/dev/null 2>&1

FILES="safeRemoveDir.desktop		\
	truecrypt-mount.desktop		\
	truecrypt-umount.desktop	\
	wipefreespace.desktop		\
	safeRemove.desktop		\
	Shred-rec.sh			\
	TrueCrypt-mount.sh		\
	openssl-decrypt.desktop		\
	Openssl-decrypt.sh		\
	openssl-encrypt.desktop		\
	"

for i in $FILES; do
	rm -f "$DESTPATH/$i"
done;

[[ -L "$HOME/bin/Shred-rec.sh"       ]] && rm -f "$HOME/bin/Shred-rec.sh"
[[ -L "$HOME/bin/TrueCrypt-mount.sh" ]] && rm -f "$HOME/bin/TrueCrypt-mount.sh"
[[ -L "$HOME/bin/Openssl-decrypt.sh" ]] && rm -f "$HOME/bin/Openssl-decrypt.sh"

unset DESTPATH
unset i
unset FILES

echo "Uninstall OK. Restart Konqueror."
exit 0
