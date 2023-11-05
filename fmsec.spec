# Special names here like {__make} come from /usr/lib/rpm/macros, /usr/lib/rpm/macros.rpmbuild

%define fmsec_version 4.0
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

%post -p /usr/bin/update-desktop-database

%postun -p /usr/bin/update-desktop-database

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
