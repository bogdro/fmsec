#!/bin/sh
#
# FMSec Xfce uninstaller
#
# Copyright (C) 2021-2023 Bogdan Drozdowski, bogdro (at) users . sourceforge . net
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

. ../common/functions.bash

dir="$HOME/.local/share/Thunar/sendto"
fmsec_uninstall "$dir"
/bin/rm -f "$dir/Openssl-encrypt.sh"

echo "Uninstall OK. Restart Thunar."
exit 0
