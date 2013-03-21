# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="NVIDIA Tegra3 X.org driver"

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
	cd Linux_for_Tegra/nv_tegra/
	unpack ./nvidia_drivers.tbz2
}

src_install() {
	cd Linux_for_Tegra/nv_tegra/
	insinto /
	doins -r usr lib etc

	# TODO: add libGLES to /usr/lib/opengl that make eselect-opengl work

	dodir /usr/lib
	       dosym libGLESv1_CM.so.1 libGLESv1_CM.so
#	       dosym /usr/lib/libGLESv1_CM.so.1 /usr/lib/libGLESv1_CM.so
	       dosym /usr/lib/libGLESv2.so.2 /usr/lib/libGLESv2.so
	       dosym /usr/lib/libEGL.so.1 /usr/lib/libEGL.so
}
