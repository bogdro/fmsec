# FMSec RPM specification file
#
# Copyright (C) 2023-2025 Bogdan Drozdowski, bogdro (at) users . sourceforge . net
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

# Special names here like {__make} come from /usr/lib/rpm/macros, /usr/lib/rpm/macros.rpmbuild

%define fmsec_version 4.6
%define fmsec_release 1
%define fmsec_name fmsec
%define fmsec_url https://fmsec.sourceforge.io
%define fmsec_lic GPLv2+
%define fmsec_summary Security extensions to file managers
%define fmsec_descr FMSec (File Manager SECurity) is a set of extensions to\
file managers that enable some security-related operations to be\
easily performed.
%define fmsec_prefix /usr

#define _unpackaged_files_terminate_build 0
%define _enable_debug_packages 0

Summary:	%{fmsec_summary}
Name:		%{fmsec_name}
Version:	%{fmsec_version}
Release:	%{fmsec_release}%{?dist}
URL:		%{fmsec_url}
BugURL:		%{fmsec_url}
License:	%{fmsec_lic}
# group must be one of the listed in /usr/share/doc/rpm-.../GROUPS or /usr/share/rpmlint/config.d/*.conf
Group:		Security
Source:		%{fmsec_name}-%{fmsec_version}.tar.gz
#BuildRoot:	{_tmppath}/{fmsec_name}-build
BuildArch:	noarch

Requires:	bash
Requires:	coreutils
Requires:	findutils
Requires:	openssl
Requires:	perl
Requires:	sed
Requires:	xterm

Requires:	libhideip
Requires:	libnetblock
Requires:	libsecrm
Requires:	wipefreespace

BuildRequires:	make

%description
%{fmsec_descr}

%prep
%setup -q

%build

%post
/usr/bin/update-desktop-database || true

%postun
/usr/bin/update-desktop-database || true

%install

%make_build install-global PREFIX=%{buildroot}/usr

%clean

%{__rm} -rf %{buildroot}

%files

%defattr(-,root,root)
%doc README
%doc COPYING
%doc AUTHORS
%doc ChangeLog
%doc INSTALL-FMSec.txt

%attr(755,-,-) %dir %{fmsec_prefix}/libexec/%{fmsec_name}
%attr(755,-,-) %{fmsec_prefix}/libexec/%{fmsec_name}/*.sh

%attr(644,-,-) %{fmsec_prefix}/share/kservices5/generate-cert.desktop
%attr(644,-,-) %{fmsec_prefix}/share/kservices5/libhideip.desktop
%attr(644,-,-) %{fmsec_prefix}/share/kservices5/libnetblock.desktop
%attr(644,-,-) %{fmsec_prefix}/share/kservices5/libsecrm.desktop
%attr(644,-,-) %{fmsec_prefix}/share/kservices5/openssl-decrypt.desktop
%attr(644,-,-) %{fmsec_prefix}/share/kservices5/openssl-encrypt.desktop
%attr(644,-,-) %{fmsec_prefix}/share/kservices5/safeRemove.desktop
%attr(644,-,-) %{fmsec_prefix}/share/kservices5/safeRemoveDir.desktop
%attr(644,-,-) %{fmsec_prefix}/share/kservices5/truecrypt-mount.desktop
%attr(644,-,-) %{fmsec_prefix}/share/kservices5/truecrypt-umount.desktop
%attr(644,-,-) %{fmsec_prefix}/share/kservices5/veracrypt-mount.desktop
%attr(644,-,-) %{fmsec_prefix}/share/kservices5/veracrypt-umount.desktop
%attr(644,-,-) %{fmsec_prefix}/share/kservices5/wipefreespace.desktop

%attr(644,-,-) %{fmsec_prefix}/share/Thunar/sendto/generate-cert.desktop
%attr(644,-,-) %{fmsec_prefix}/share/Thunar/sendto/libhideip.desktop
%attr(644,-,-) %{fmsec_prefix}/share/Thunar/sendto/libnetblock.desktop
%attr(644,-,-) %{fmsec_prefix}/share/Thunar/sendto/libsecrm.desktop
%attr(644,-,-) %{fmsec_prefix}/share/Thunar/sendto/openssl-decrypt.desktop
%attr(644,-,-) %{fmsec_prefix}/share/Thunar/sendto/openssl-encrypt.desktop
%attr(644,-,-) %{fmsec_prefix}/share/Thunar/sendto/safeRemove.desktop
%attr(644,-,-) %{fmsec_prefix}/share/Thunar/sendto/safeRemoveDir.desktop
%attr(644,-,-) %{fmsec_prefix}/share/Thunar/sendto/veracrypt-mount.desktop
%attr(644,-,-) %{fmsec_prefix}/share/Thunar/sendto/veracrypt-umount.desktop
%attr(644,-,-) %{fmsec_prefix}/share/Thunar/sendto/wipefreespace.desktop

%changelog
