# FMSec #

FMSec (File Manager SECurity) is a set of extensions to file managers that
enable some security-related operations to be easily performed.

The operations are:

-   encryption and decryption using OpenSSL (<https://www.openssl.org/>),
-   safe removing (shredding) files and directories,
-   mounting and unmounting TrueCrypt and VeraCrypt (<https://www.veracrypt.fr/en/>) volumes,
-   wiping the free space on a filesystem using WipeFreeSpace (<https://wipefreespace.sourceforge.io/>),
-   running programs with LibSecRm (<https://libsecrm.sourceforge.io/>) preloaded,
-   running programs with LibHideIP (<https://libhideip.sourceforge.io/>) preloaded,
-   running programs with LibNetBlock (<https://libnetblock.sourceforge.io/>) preloaded.

Read the info documentation in the package to get more information.

FMSec homepage: <https://fmsec.sourceforge.io/>

Author: Bogdan Drozdowski, bogdro (at) users . sourceforge . net

License: GPLv2+

----------------------------------------------------------------

## Compatibility ##

FMSec supports the following file managers:

1.  [KDE](https://kde.org/) 3.x:
  - Konqueror

2.  [KDE](https://kde.org/) 4.x:
  - Konqueror
  - Dolphin

3.  [KDE](https://kde.org/) 5.x:
  - Konqueror
  - Dolphin
  - Krusader

4.  [Xfce](https://xfce.org/) 4.x:
  - Thunar

----------------------------------------------------------------

## WARNING ##

The `dev` branch may contain code which is a work in progress and committed just for tests. The code here may not work properly.

The `master` branch may contain code which is committed just for quality tests.

The tags, matching the official packages on SourceForge, should be the most reliable points.
