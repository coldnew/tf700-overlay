# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

# Based on Gentoo's official xf86-input-evdev-2.5.0.ebuild
EAPI=4

HOMEPAGE="http://gitorious.org/xorg/xf86-input-mtev"
DESCRIPTION="Multitouch input driver for Xorg used in MeeGo project"
KEYWORDS="~arm ~amd64"
IUSE="mtdev"
XORG_EAUTORECONF="yes"

inherit  git-2 eutils
GIT_ECLASS="git-2"
EGIT_REPO_URI="git://gitorious.org/gabrbedd/xorg-x11-drv-mtev.git"

#EGIT_REPO_URI="git://gitorious.org/xorg/xf86-input-mtev.git"
# Set this if you compile from a branch other than master.
# EGIT_BRANCH="my-branch"
# Set this if you compile from a commit other than HEAD.
#EGIT_COMMIT="92ce666"
#EGIT_BRANCH="master"

RESTRICT="mirror"
SLOT=0

RDEPEND="sys-libs/mtdev
		 >=x11-base/xorg-server-1.12.4[udev]"

DEPEND="${RDEPEND}
	>=sys-kernel/linux-headers-2.6
	>=x11-proto/inputproto-2.1.99.3"

S="${WORKDIR}/${P}"
BUILD_DIR="${S}"

src_prepare() {
#	epatch "${FILESDIR}"/ABI_12.patch
	cd "${S}"
	tar xvf *.tar.gz
	cd "${S}"/xorg-x11-drv-mtev-0.1.13
	epatch ../xorg-x11-drv-mtev-0.1.13-update-code-for-xserver-1.11.patch
	epatch ../xorg-x11-drv-mtev-0.1.13-add-right-mouse-button-emulation.patch
}

src_compile() {
	cd "${S}"/xorg-x11-drv-mtev-0.1.13
	emake || doe "emake failed."
}

# src_install() {
# 	xorg-2_src_install
# 	dodoc README*
# }

# This patch is cherry-picked in ahm-2.7.0
# PATCHES=(
# 	"${FILESDIR}"/${PN}-2.7.0-horizontal-scrolling.patch
# )
