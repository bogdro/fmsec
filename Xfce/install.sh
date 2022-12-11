#!/bin/sh
#
# FMSec Xfce installer
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

. ../common/functions.bash

fmsec_install "$HOME/.local/share/Thunar/sendto"
[[ ! -e "$HOME/bin/Openssl-encrypt.sh" ]] && /bin/ln -s "$HOME/.local/share/Thunar/sendto/Openssl-encrypt.sh" "$HOME/bin/Openssl-encrypt.sh"

echo "Install OK. Restart Thunar."
exit 0