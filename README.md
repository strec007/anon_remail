# anon_remail

Processes messages for anonymous mailing using type-I (Cypherpunk) anonymous remailers

## Usage

```
anon_remail [-list|-keys|-new] [remailer]
```

Reads message from the standard input, encrypts it for the given remailer, adds
some headers and prints the result to the standard output.

### Parameters:

* *-list*: prints list of remailers and some more info
* *-keys*: prints the block of PGP keys to import
* *-new*:  prints a template of a new message to fill in

* *remailer*: name of the remailer

### Example:

- Import keys:
```sh
anon_remail -keys | gpg --import
```

- Send anonymous e-mail

```sh
anon_remail -new > msg.txt
#edit it
vi msg.txt
cat msg.txt | anon_remail austria | anon_remail fotonl | msmtp --account gmail -t
```

## License

Copyright 2017 Dr. Petr Cizmar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

