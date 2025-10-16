#!/bin/bash
#
# "Generate a certificate" context menu entry - program.
#
# This is a script that generates a main certificate (if it doesn't exist yet)
#  and a client certificate, signed by the main one.
#
# The certificates and their database are created in the given directory.
#
# Copyright (C) 2009-2025 Bogdan Drozdowski, bogdro (at) users . sourceforge . net
#
# This file is part of FMSec (File Manager SECurity), a set of extensions
#  to file managers.
# FMSec homepage: https://fmsec.sourceforge.io/
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 3
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
#  along with this program. If not, see <https://www.gnu.org/licenses/>.
#

if [[ $# -lt 1 ]]; then

	exit 1;
fi;

if [[ ! -d "$1" ]]; then

	exit 2;
fi

cd "$1" || exit 3

if [[ ! -e maincert_cert.der ]]; then
	echo ===== Generating the main key/certificate
	openssl req -x509 -days 10950 -newkey rsa:2048 \
		-keyout maincert_key.pem \
		-out maincert_cert.pem
	openssl x509 -in maincert_cert.pem -outform DER -out maincert_cert.der

	mkdir certs
	mkdir newcerts
	mkdir crl
	touch index.txt
	echo "01" > serial

	# depends on the OpenSSL configuration:
	mkdir demoCA
	mkdir demoCA/certs
	mkdir demoCA/newcerts
	mkdir demoCA/crl
	touch demoCA/index.txt
	echo "01" > demoCA/serial
fi

for ((i=0; i<4000000000; i++)); do

	if [[ ! -e cert$i.pem ]]; then break; fi
done

name=cert$i

echo ===== Generating a certificate request $name.req and key $name.key
openssl req -newkey rsa:2048 -keyout $name.key -out $name.req

echo ===== Signing the certificate request $name.req
openssl ca -days 10000 -cert maincert_cert.pem -keyfile maincert_key.pem \
	-in $name.req -out $name.pem

echo ===== Exporting the signed certificate $name.pem with private key to $name.p12
openssl pkcs12 -export -in $name.pem -inkey $name.key -out $name.p12 \
	-name "Certificate for $name"

echo ===== Exporting the public certificate to $name-pub.pem
openssl pkcs12 -in $name.p12 -out $name-pub.pem -nokeys -clcerts

echo ===== Converting the public certificate to DER format: $name-pub.cer
openssl x509 -in $name-pub.pem -outform DER -out $name-pub.cer

echo ===== Converting the public certificate to PKCS#7 format: $name-pub.p7b
openssl crl2pkcs7 -nocrl -certfile $name-pub.pem -outform DER \
	-out $name-pub.p7b

echo ===== Packing the files to $name-certs.zip
zip $name-certs $name.key $name.p12 $name-pub.pem $name-pub.cer $name-pub.p7b

echo ===== Done. Press any key.
read

exit 0
