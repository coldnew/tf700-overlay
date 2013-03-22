# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="X11 keyboard layout for ASUS tf700"
HOMEPAGE=""
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm"
DEPEND="x11-misc/kbdd"

src_unpack() {
             # dummy function, prevent error
 	     mkdir tf700-keyboard-0.0.1
}

src_install() {
    dodir /usr/share/X11/xkb/symbols/
    insinto "/usr/share/X11/xkb/symbols/"
    doins -r "${FILESDIR}/tf201dock" || die "doins failed"
}
