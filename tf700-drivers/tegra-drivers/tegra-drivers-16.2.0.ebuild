# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="NVIDIA Tegra2 X.org driver"

HOMEPAGE="https://developer.nvidia.com/linux-tegra"
SRC_URI="http://developer.download.nvidia.com/akamai/mobile/files/L4T/cardhu_Tegra-Linux-R${PV}_armhf.tbz2"


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
	cd nv_tegra/
	unpack ./nvidia_drivers.tbz2
}

src_install() {
	cd nv_tegra/
	insinto /
	doins -r usr lib etc
}
