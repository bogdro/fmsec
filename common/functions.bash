# FMSec installers - common functions
#
# Copyright (C) 2021 Bogdan 'bogdro' Drozdowski, bogdro (at) users . sourceforge . net
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

SHFILES="Shred-rec.sh			\
	Openssl-decrypt.sh		\
	TrueCrypt-mount.sh		\
	VeraCrypt-mount.sh		\
	"

FILES="safeRemoveDir.desktop		\
	safeRemove.desktop		\
	openssl-decrypt.desktop		\
	openssl-encrypt.desktop		\
	truecrypt-mount.desktop		\
	truecrypt-umount.desktop	\
	veracrypt-mount.desktop		\
	veracrypt-umount.desktop	\
	wipefreespace.desktop		\
	"

FILES="$FILES $SHFILES"

function fmsec_install
{
	dest=$1
	if ( test -z "$dest" ); then

		echo "Missing destination directory."
		exit 2
	fi

	/bin/mkdir -p "$dest" 2>/dev/null
	/bin/cp -f desktop/* ../common/*.sh "$dest"

	if ( test -e "$HOME/bin" && ! test -d "$HOME/bin" ); then

		echo "$HOME/bin exists, but is not a directory. Fix this. Install partially failed (*.sh scripts not installed)."
		exit 3
	fi

	[[ ! -e "$HOME/bin" ]] && /bin/mkdir "$HOME/bin"

	if ( ! test -d "$HOME/bin" ); then

		echo "$HOME/bin can't be created. Install partially failed."
		exit 4
	fi

	for i in $SHFILES; do

		[[ ! -e "$HOME/bin/$i" ]] && /bin/ln -s "$dest/$i" "$HOME/bin/$i"
	done;

	for i in $SHFILES; do

		if (! test -e "$HOME/bin/$i"); then

			echo "Install partially failed: '$HOME/bin/$i' not created."
			exit 5
		fi

	done;
}

function fmsec_uninstall
{
	dest=$1
	if ( test -z "$dest" ); then

		echo "Missing destination directory."
		exit 2
	fi

	for i in $FILES; do
		/bin/rm -f "$dest/$i"
	done;

	for i in $SHFILES; do

		[[ -L "$HOME/bin/$i" ]] && /bin/rm -f "$HOME/bin/$i"
	done;
}
