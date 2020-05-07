# CheckLaTeXPackageCompability

This downloads all sorts of packages from CTAN and then tests if it can compile those alone and if so, tests if it can compile them with other packages. Creates a list of incompatible packages in the end. 

First, run `download.pl`, then `test_packages.pl`. From then on, everything will be done automatically.

Needs `pdflatex`, `wget`, `unzip`, `zipinfo` and the following perl packages:

> LWP::Simple

> Data::Dumper

> Digest::MD5

> Smart::Comments

> Term::ANSIColor

> File::Touch

> File::Basename

# Incompatible modules

The following modules were found to be incompatible, though this list is in no way exhaustive (only tested about 2% of all possible combinations!).2% of all possible combinations!).

abnt-etoolbox
biblatex-opcit-booktitle-etoolbox
biblatex-source-division-etoolbox
bohr-etoolbox
bohr-zwpagelayout
bxcalc-etoolbox
cmcyralt-hithesis
cmcyralt-hitszthesis
cmpj-arsclassica
cmpj-chs-physics-report
cmpj-classicthesis
cmpj-ftc-notebook
cmpj-mdwfonts
cmpj-musical
cmpj-stdpage
cmpj-uassign
cmpj-url
cnltx-etoolbox
cnltx-zwpagelayout
cntformats-etoolbox
cntformats-zwpagelayout
colourchange-etoolbox
colourchange-ghsystem
coolthms-etoolbox
coolthms-ghsystem
coolthms-url
crossreftools-mdwfonts
ddphonism-etoolbox
doi-url
econometrics-chemexec
enotez-etoolbox
eqexpl-etoolbox
exercisebank-zwpagelayout
extpfeil-easyformat
extpfeil-ling-macros
extpfeil-nath
feupphdteses-mdwfonts
feupphdteses-philex
feupphdteses-url
feupphdteses-zwpagelayout
fnpct-etoolbox
genealogytree-etoolbox
genealogytree-ghsystem
genealogytree-pgfkeyx
genealogytree-zwpagelayout
grid-arsclassica
grid-chs-physics-report
grid-classicthesis
grid-ftc-notebook
grid-musical
grid-stdpage
grid-uassign
hepunits-linguex
hepunits-philex
hep-url
hithesis-etoolbox
hithesis-ghsystem
hithesis-linguex
hithesis-philex
hitszthesis-etoolbox
hitszthesis-ghsystem
hitszthesis-linguex
hitszthesis-philex
ifthenx-typeface
invoice-linguex
invoice-philex
jumplines-etoolbox
jumplines-mdwfonts
jumplines-url
jumplines-zwpagelayout
ku-template-zwpagelayout
manyind-ghsystem
manyind-isomath
manyind-thumby
noindentafter-etoolbox
opteng-arsclassica
opteng-chs-physics-report
opteng-classicthesis
opteng-ftc-notebook
opteng-musical
opteng-stdpage
opteng-uassign
pdfcomment-etoolbox
pdfcomment-ghsystem
pdfcomment-url
pdfpagediff-flashmovie
pdfslide-arsclassica
pdfslide-chs-physics-report
pdfslide-classicthesis
pdfslide-ftc-notebook
pdfslide-musical
pdfslide-stdpage
pdfslide-uassign
pdfslide-url
perfectcut-etoolbox
procIAGssymp-arsclassica
procIAGssymp-chs-physics-report
procIAGssymp-classicthesis
procIAGssymp-ftc-notebook
procIAGssymp-musical
procIAGssymp-stdpage
procIAGssymp-uassign
refenums-csquotes
refenums-etoolbox
refenums-url
ribbonproofs-biblatex2bibitem
ribbonproofs-biblatex-bookinarticle
ribbonproofs-etoolbox
ribbonproofs-flashmovie
ribbonproofs-gitlog
ribbonproofs-translations
simpler-wick-zwpagelayout
tagging-etoolbox
tdclock-url
tdclock-zwpagelayout
technics-url
turabian-formatting-arsclassica
turabian-formatting-chs-physics-report
turabian-formatting-classicthesis
turabian-formatting-etoolbox
turabian-formatting-ftc-notebook
turabian-formatting-musical
turabian-formatting-stdpage
turabian-formatting-uassign
unswcover-ghsystem
unswcover-substances
unswcover-zwpagelayout
vtable-etoolbox
wallpaper-zwpagelayout
xyling-sdrt

