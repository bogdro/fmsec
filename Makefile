# FMSec Makefile
#
# Copyright (C) 2021-2025 Bogdan Drozdowski, bogdro (at) users . sourceforge . net
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
VER = 4.5

RMDIR = /bin/rm -fr
# when using '-p', no error is generated when the directory exists
MKDIR = /bin/mkdir -p
COPY = /bin/cp -fr
SED = /bin/sed -i

# Use the GNU tar format
# ifneq ($(shell tar --version | grep -i bsd),)
# PACK1_GNUOPTS = --format gnutar
# endif
PACK1 = /bin/tar $(PACK1_GNUOPTS) -vcf
PACK1_EXT = .tar

PACK2 = /usr/bin/gzip -9
PACK2_EXT = .gz

SUBDIRS = common KDE3 KDE4 KDE5 Xfce

DISTFILES = AUTHORS ChangeLog COPYING fmsec.spec INSTALL-FMSec.txt \
	install-all.sh Makefile NEWS README uninstall-all.sh

ifeq ($(PREFIX),)
PREFIX = /usr
endif

GLOBAL_DESKTOP_DIR_KDE5 = $(PREFIX)/share/kservices5
GLOBAL_DESKTOP_DIR_XFCE = $(PREFIX)/share/Thunar/sendto
GLOBAL_SHARE_DIR = $(PREFIX)/libexec/$(NAME)

all:	dist

######################################### Distribution

dist:	$(NAME)-$(VER)$(PACK1_EXT)$(PACK2_EXT)

$(NAME)-$(VER)$(PACK1_EXT)$(PACK2_EXT): $(DISTFILES) \
		$(shell find $(SUBDIRS) -type f)
	$(RMDIR) $(NAME)-$(VER)
	$(MKDIR) $(NAME)-$(VER)
	$(COPY) $(DISTFILES) $(SUBDIRS) $(NAME)-$(VER)
	$(PACK1) $(NAME)-$(VER)$(PACK1_EXT) $(NAME)-$(VER)
	$(PACK2) $(NAME)-$(VER)$(PACK1_EXT)
	$(RMDIR) $(NAME)-$(VER)

######################################### Installation

install-KDE3:
	cd KDE3 && ./install.sh

install-KDE4:
	cd KDE4 && ./install.sh

install-KDE5:
	cd KDE5 && ./install.sh

install-Xfce:
	cd Xfce && ./install.sh

install-all: install-KDE3 install-KDE4 install-KDE5 install-Xfce

install-global-mkdir:
	$(MKDIR) $(GLOBAL_SHARE_DIR)

install-global-KDE5: install-global-mkdir
	$(MKDIR) $(GLOBAL_DESKTOP_DIR_KDE5)
	$(COPY) KDE5/desktop/*.desktop $(GLOBAL_DESKTOP_DIR_KDE5)

install-global-Xfce: install-global-mkdir
	$(MKDIR) $(GLOBAL_DESKTOP_DIR_XFCE)
	$(COPY) Xfce/desktop/*.desktop $(GLOBAL_DESKTOP_DIR_XFCE)
	$(COPY) Xfce/desktop/*.sh $(GLOBAL_SHARE_DIR)

install-global: install-global-mkdir install-global-KDE5 install-global-Xfce
	$(COPY) common/*.sh $(GLOBAL_SHARE_DIR)
	$(SED) 's#$$HOME/bin#$(GLOBAL_SHARE_DIR)/#g' $(GLOBAL_DESKTOP_DIR_XFCE)/*.desktop

######################################### Uninstallation

uninstall-KDE3:
	cd KDE3 && ./uninstall.sh

uninstall-KDE4:
	cd KDE4 && ./uninstall.sh

uninstall-KDE5:
	cd KDE5 && ./uninstall.sh

uninstall-Xfce:
	cd Xfce && ./uninstall.sh

uninstall-all: uninstall-KDE3 uninstall-KDE4 uninstall-KDE5 uninstall-Xfce

uninstall-global-rmdir:
	$(RMDIR) $(GLOBAL_SHARE_DIR)

uninstall-global-KDE5:
	$(shell cd KDE5/desktop/; for f in *.desktop; do $(RMDIR) $(GLOBAL_DESKTOP_DIR_KDE5)/$$f; done; cd ../..)

uninstall-global-Xfce:
	$(shell cd Xfce/desktop/; for f in *.{desktop,sh}; do $(RMDIR) $(GLOBAL_DESKTOP_DIR_XFCE)/$$f; done; cd ../..)

uninstall-global: uninstall-global-KDE5 uninstall-global-Xfce uninstall-global-rmdir

#########################################

.PHONY: all dist \
	install-all install-KDE3 install-KDE4 install-KDE5 install-Xfce \
	uninstall-all uninstall-KDE3 uninstall-KDE4 uninstall-KDE5 uninstall-Xfce \
	install-global install-global-mkdir install-global-KDE5 install-global-Xfce \
	uninstall-global uninstall-global-rmdir uninstall-global-KDE5 uninstall-global-Xfce
