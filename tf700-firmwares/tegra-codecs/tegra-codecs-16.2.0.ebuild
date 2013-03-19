# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="NVIDIA Tegra2 X.org driver"

HOMEPAGE="https://developer.nvidia.com/linux-tegra"
SRC_URI="http://developer.download.nvidia.com/akamai/mobile/files/L4T/cardhu_Tegra-Linux-codecs-R${PV}_armhf.tbz2"


LICENSE="nvidia"
SLOT="0"
KEYWORDS="~arm"

IUSE=""
#DEPEND="=sys-libs/tegra-libs-${PV}"
DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"
RESTRICT="strip mirror"

src_unpack() {
	unpack ${A}
	unpack ./restricted_codecs.tbz2
}

src_install() {
	insinto /
	doins -r lib
}
