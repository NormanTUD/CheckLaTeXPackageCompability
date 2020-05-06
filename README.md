# CheckLaTeXPackageCompability

This downloads all sorts of packages from CTAN and then tests if it can compile those alone and if so, tests if it can compile them with other packages. Creates a list of incompatible packages in the end. 

First, run `download.pl`, then `test_packages.pl`. From then on, everything will be done automatically.

Needs `pdflatex`, `wget`, `unzip`, `zipinfo` and the following packages:

> LWP::Simple;
> Data::Dumper;
> Digest::MD5 qw/md5_hex/;
> Smart::Comments;
> Term::ANSIColor;
> File::Touch;
> File::Basename;
