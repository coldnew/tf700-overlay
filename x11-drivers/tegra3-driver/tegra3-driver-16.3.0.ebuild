# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="NVIDIA Tegra3 X.org driver"

HOMEPAGE="https://developer.nvidia.com/linux-tegra"
SRC_URI="http://developer.nvidia.com/sites/default/files/akamai/mobile/files/L4T/cardhu_Tegra-Linux-R16.3.0_armhf.tbz2"

LICENSE="nvidia"
SLOT="0"
KEYWORDS="~arm"

IUSE=""
DEPEND="=media-libs/tegra3-codecs-16.3.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Linux_for_Tegra/nv_tegra/"
T="/usr/lib/opengl/tegra3/lib"

RESTRICT="strip mirror"

src_unpack() {
	unpack ${A}
	cd Linux_for_Tegra/nv_tegra/
	unpack ./nvidia_drivers.tbz2
}

src_install() {
	dodir /usr/lib/opengl/tegra3/lib

	cd "${S}/usr/lib/"
	#insinto  "${T}"
	insinto /usr/lib/opengl/tegra3/lib
	doins libGLESv1_CM.so.1
	doins libGLESv2.so.2
	doins libEGL.so.1

	insinto /usr/lib/opengl/tegra3
	touch .gles-only
	doins .gles-only

#	dodir /usr/lib/opengl/tegra3/lib/
	dosym libGLESv1_CM.so.1 /usr/lib/opengl/tegra3/lib/libGLESv1_CM.so
	dosym libGLESv2.so.2 /usr/lib/opengl/tegra3/lib/libGLESv2.so
	dosym libEGL.so.1 /usr/lib/tegra3/lib/libEGL.so
	#dosym libGLESv1_CM.so.1 "${T}"/libGLESv1_CM.so
	#dosym libGLESv2.so.2 "${T}"/libGLESv2.so
	#dosym libEGL.so.1 "${T}"/libEGL.so

	#cd "${S}/usr/lib/"
	#rm libGLESv1_CM.so
	#rm libGLESv2.so.2
	#rm libEGL.so.1

	cd "${S}"
	insinto /
	doins -r usr lib etc

	# FIXME: find xwindow abi
	dodir /usr/lib/xorg/modules/drivers
	dosym tegra_drv.abi13.so /usr/lib/xorg/modules/drivers/tegra_drv.so
}
