# FMSec Makefile
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

NAME = fmsec
VER = 4.0

RMDIR = /bin/rm -fr
MKDIR = /bin/mkdir
COPY = /bin/cp -r

PACK1 = /bin/tar --format gnutar -vcf
PACK1_EXT = .tar

PACK2 = /usr/bin/gzip -9
PACK2_EXT = .gz

SUBDIRS = common KDE3 KDE4 KDE5 Xfce

all:	dist

dist:	$(NAME)-$(VER)$(PACK1_EXT)$(PACK2_EXT)

$(NAME)-$(VER)$(PACK1_EXT)$(PACK2_EXT): AUTHORS ChangeLog COPYING NEWS README \
		INSTALL-FMSec.txt install-all.sh uninstall-all.sh Makefile \
		$(shell find $(SUBDIRS) -type f)
	$(RMDIR) $(NAME)-$(VER)
	$(MKDIR) $(NAME)-$(VER)
	$(COPY) AUTHORS ChangeLog COPYING INSTALL-FMSec.txt NEWS README \
		install-all.sh uninstall-all.sh Makefile $(SUBDIRS) \
		$(NAME)-$(VER)
	$(PACK1) $(NAME)-$(VER)$(PACK1_EXT) $(NAME)-$(VER)
	$(PACK2) $(NAME)-$(VER)$(PACK1_EXT)
	$(RMDIR) $(NAME)-$(VER)

.PHONY: all dist
