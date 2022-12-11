#!/bin/sh
#
# Konqueror context menu entries' installer
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

if ( test -z "$HOME" ); then

	if ( test -d /home/`whoami` ); then

		HOME=/home/`whoami`
	else
		echo "Set 'HOME' to your home directory and re-run this script."
		exit 1
	fi
fi

if ( test -z "$KDEHOME" ); then

	if ( test -d $HOME/.kde ); then

		KDEHOME=$HOME/.kde
	else
		echo "Set KDEHOME to your home KDE directory and re-run this script."
		exit 2
	fi
fi

if ( test -e $HOME/bin && ! test -d $HOME/bin ); then

	echo "$HOME/bin exists, but not a directory. Fix this. Install failed."
	exit 3
fi

[[ ! -e $HOME/bin ]] && mkdir $HOME/bin

if ( ! test -d $HOME/bin ); then

	echo "$HOME/bin can't be created. Install failed."
	exit 4
fi

DESTPATH=$KDEHOME/share/apps/konqueror/servicemenus

unalias mkdir >/dev/null 2>&1
unalias cp    >/dev/null 2>&1

mkdir -p $DESTPATH
cp -f desktop/* $DESTPATH

[[ ! -e $HOME/bin/Shred-rec.sh       ]] && ln -s $DESTPATH/Shred-rec.sh       $HOME/bin/Shred-rec.sh
[[ ! -e $HOME/bin/TrueCrypt-mount.sh ]] && ln -s $DESTPATH/TrueCrypt-mount.sh $HOME/bin/TrueCrypt-mount.sh
[[ ! -e $HOME/bin/Openssl-decrypt.sh ]] && ln -s $DESTPATH/Openssl-decrypt.sh $HOME/bin/Openssl-decrypt.sh

if (       ! test -e $HOME/bin/Shred-rec.sh		\
	|| ! test -e $HOME/bin/TrueCrypt-mount.sh	\
	|| ! test -e $HOME/bin/Openssl-decrypt.sh	\
   ); then

	echo "Install failed."
	exit 5
fi

echo "Install OK. Restart Konqueror."
