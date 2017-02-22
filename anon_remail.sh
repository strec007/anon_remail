#!/bin/bash

# Copyright 2017 Dr. Petr Cizmar
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

PAR=$1

[[ ${PAR:0:1} == '-'  || "$PAR" == "" ]] || {
  TO=$(curl -s http://www.noreply.org/echolot/rlist.txt | sed -rn '/\$remailer\{"'"$PAR"'"\}/s/^.*<([^>]*)>.*$/\1/p')

   [[ -z $TO ]] && {
	 echo Wrong ID.
	 echo Look at $0 -list
	 echo
	 exit 1
   }
}

case "$1" in
	 "-list")
		curl http://www.noreply.org/echolot/rlist.txt
		exit 0
		;;
	 "-keys")
		curl http://www.noreply.org/echolot/pgp-all.asc
		exit 0
		;;
	 "-new")
		cat << EOF
::
Anon-To:

##
Subject:

<Message>
EOF
		exit 0
		;;
	 "")
		cat << EOF

Usage: $0 [-list|-keys|-new] [remailer]

Reads message from the standard input, encrypts it for the given remailer, adds
some headers and prints the result to the standard output.

Parameters:
-list: prints list of remailers and some more info
-keys: prints the block of PGP keys to import
-new:  prints a template of a new message to fill in

remailer: name of the remailer

Example:

- Import keys:
$0 -keys | gpg --import

- Send anonymous e-mail
$0 -new > msg.txt
#edit it
vi msg.txt
cat msg.txt | $0 austria | $0 fotonl | msmtp --account gmail -t

EOF
		exit 0
		;;

esac

MSG=$(cat)

ENCMSG=$(echo "$MSG" | \
sed 's/^To:\s*/Anon-To:/' | \
gpg -ea --batch --trust-model always -r $TO)

cat << EOF
To: $TO
Subject: Anonymous E-mail

::
Encrypted: PGP

$ENCMSG
EOF
