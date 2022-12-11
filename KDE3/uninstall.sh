#!/bin/sh
#
# Konqueror context menu entries' uninstaller
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
