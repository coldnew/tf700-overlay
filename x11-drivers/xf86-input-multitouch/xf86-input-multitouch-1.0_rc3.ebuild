# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

#inherit x-modular
inherit  git-2

DESCRIPTION="Multitouch-X-Driver for MT-Touchpads"
HOMEPAGE="http://bitmath.org/code/multitouch/"
#SRC_URI="http://github.com/rydberg/Multitouch-X-Driver/tarball/v${PV/_/-} -> ${P}.tar.gz"

GIT_ECLASS="git-2"
EGIT_REPO_URI="https://github.com/rydberg/Multitouch-X-Driver.git"
EGIT_COMMIT="55ab6c4ec"
S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm"

RDEPEND="
	x11-base/xorg-server"
DEPEND="${RDEPEND}
	x11-proto/inputproto"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

}

pkg_postinst() {
	echo
	elog "To enable multitouch support add the following lines"
	elog "to your xorg.conf:"
	elog ""
	elog "Section \"InputClass\""
	elog " MatchIsTouchpad \"true\""
	elog " Driver \"multitouch\""
	elog " Identifier \"touchpad\""
	elog "EndSection"
	elog ""
}

