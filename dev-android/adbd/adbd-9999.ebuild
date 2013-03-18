# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils git-2 toolchain-funcs

DESCRIPTION="Android Debug Bridge server daemon"
HOMEPAGE="https://android.googlesource.com/"
EGIT_PROJECT="aosp/platform/system/core"
EGIT_REPO_URI="https://android.googlesource.com/platform/system/core"
SRC_URI="http://achurch.org/portage-tf700-distfiles/adbd-build.tar.gz"
EGIT_NOUNPACK=1  # We do it ourselves.

KEYWORDS="~amd64 ~arm ~x86"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack() {
	git-2_src_unpack
	cd "${S}"
	unpack ${A}
}

src_compile() {
	emake -C adbd-build CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin "${S}/adbd-build/adbd"
	mkdir -p "${D}/etc/init.d"
	cp "${FILESDIR}/adbd-init" "${D}/etc/init.d/adbd"
}
