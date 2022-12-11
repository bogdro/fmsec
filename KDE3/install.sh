#!/bin/sh
#
# Konqueror context menu entries' installer
#
# Copyright (C) 2007,2010 Bogdan 'bogdro' Drozdowski, bogdandr # op . pl
#	[EN] http://miniurl.pl/bogdro-soft
#
# This file may be used only according to the licence of Konqueror itself.
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

unalias mkdir >/dev/null 2>&1
unalias cp    >/dev/null 2>&1

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

mkdir -p "$DESTPATH"
cp -f $FILES "$DESTPATH"

if ( test -e "$HOME/bin" && ! test -d "$HOME/bin" ); then

	unset DESTPATH
	unset FILES

	echo "$HOME/bin exists, but not a directory. Fix this. Install failed."
	exit 3
fi

[[ ! -e "$HOME/bin" ]] && mkdir "$HOME/bin"

if ( ! test -d "$HOME/bin" ); then

	unset DESTPATH
	unset FILES

	echo "$HOME/bin can't be created. Install failed."
	exit 4
fi

[[ ! -e "$HOME/bin/Shred-rec.sh"       ]] && ln -s "$DESTPATH/Shred-rec.sh"       "$HOME/bin/Shred-rec.sh"
[[ ! -e "$HOME/bin/TrueCrypt-mount.sh" ]] && ln -s "$DESTPATH/TrueCrypt-mount.sh" "$HOME/bin/TrueCrypt-mount.sh"
[[ ! -e "$HOME/bin/Openssl-decrypt.sh" ]] && ln -s "$DESTPATH/Openssl-decrypt.sh" "$HOME/bin/Openssl-decrypt.sh"

if (       ! test -e "$HOME/bin/Shred-rec.sh"		\
	|| ! test -e "$HOME/bin/TrueCrypt-mount.sh"	\
	|| ! test -e "$HOME/bin/Openssl-decrypt.sh"	\
   ); then

	unset DESTPATH
	unset FILES

	echo "Install failed."
	exit 5
fi

unset DESTPATH
unset FILES

echo "Install OK. Restart Konqueror."
