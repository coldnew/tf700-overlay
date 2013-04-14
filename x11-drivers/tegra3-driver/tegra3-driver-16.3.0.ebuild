# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

JPEG_ABI=8

inherit eutils

DESCRIPTION="NVIDIA Tegra3 X.org driver"
HOMEPAGE="https://developer.nvidia.com/linux-tegra"
SRC_URI="http://developer.nvidia.com/sites/default/files/akamai/mobile/files/L4T/cardhu_Tegra-Linux-R${PV}_armhf.tbz2"

LICENSE="nvidia"
SLOT="0"
KEYWORDS="~arm ~amd64"
IUSE="+X"
DEPEND="=media-libs/tegra3-codecs-${PV}
	X? (
	   <x11-base/xorg-server-1.14.0
	   >=x11-base/xorg-server-1.13.0
	   >=app-admin/eselect-opengl-1.0.9
	)
	!media-libs/jpeg:0
	!media-libs/libjpeg-turbo:0"

RDEPEND="${DEPEND}"

S="${WORKDIR}/Linux_for_Tegra/nv_tegra/"


RESTRICT="bindist strip mirror"

# Install nvidia library:
# the first parameter is the library to install
# the second parameter is the provided soversion
# the third parameter is the target directory if its not /usr/lib
donvidia() {
	# Full path to library minus SOVER
	MY_LIB="$1"

	# SOVER to use
	MY_SOVER="$2"

	# Where to install
	MY_DEST="$3"

	if [[ -z "${MY_DEST}" ]]; then
		MY_DEST="/usr/$(get_libdir)"
		action="dolib.so"
	else
		exeinto ${MY_DEST}
		action="doexe"
	fi

	# Get just the library name
	libname=$(basename $1)

	# Install the library with the correct SOVER
	${action} ${MY_LIB}.${MY_SOVER} || \
		die "failed to install ${libname}"

	# If SOVER wasn't 1, then we need to create a .1 symlink
	if [[ "${MY_SOVER}" != "1" ]]; then
		dosym ${libname}.${MY_SOVER} \
			${MY_DEST}/${libname}.1 || \
			die "failed to create ${libname} symlink"
	fi

	# Always create the symlink from the raw lib to the .1
	dosym ${libname}.1 \
		${MY_DEST}/${libname} || \
		die "failed to create ${libname} symlink"
}

pkg_setup() {
	NV_LIB="${S}/usr/lib"
	NV_X11="${NV_LIB}/xorg/modules/drivers"
	NV_SOVER=1
}

src_unpack() {
	unpack "${A}"
	cd "${S}"
	unpack ./nvidia_drivers.tbz2

	# rename tegra_drv.abi13.so to tegra_drv.so
	cd "${S}/usr/lib/xorg/modules/drivers"
	mv tegra_drv.abi13.so tegra_drv.so

	# create dummy file .gles-only, this file is used to let eselect-opengl
	# know we only have gles libs
	cd "${S}/usr/lib"
	touch .gles-only

	# rename libjpeg.so to libjpeg.so.8
	mv libjpeg.so  libjpeg.so.${JPEG_ABI}
}

src_install() {
	local inslibdir=$(get_libdir)
	local GL_ROOT="/usr/$(get_libdir)/opengl/tegra3/lib"
	local libdir=${NV_LIB}

	if use X; then
		# The GLES libraries
		donvidia ${libdir}/libEGL.so ${NV_SOVER} ${GL_ROOT}
		donvidia ${libdir}/libGLESv1_CM.so ${NV_SOVER} ${GL_ROOT}
		donvidia ${libdir}/libGLESv2.so 2 ${GL_ROOT}

		# Since we only have gles lib, we need to add .gles-only
		# to make eselect-opengl work properly
		#touch /usr/$(get_libdir)/opengl/tegra3/.gles-only
		insinto /usr/$(get_libdir)/opengl/tegra3
		doins ${libdir}/.gles-only

		# Install Xorg DDX driver
		insinto /usr/$(get_libdir)/xorg/modules/drivers
		doins ${NV_X11}/tegra_drv.so || die "failed to install tegra_drv.so"
	fi

	# Install firmwares, tegra version info
	insinto /
	doins -r lib etc

	# Install other libs
	dolib.so ${libdir}/libardrv_dynamic.so
	dolib.so ${libdir}/libcgdrv.so
	dolib.so ${libdir}/libKD.so
	dolib.so ${libdir}/libnvapputil.so
	dolib.so ${libdir}/libnvavp.so
	dolib.so ${libdir}/libnvcwm.so
	dolib.so ${libdir}/libnvdc.so
	dolib.so ${libdir}/libnvddk_2d.so
	dolib.so ${libdir}/libnvddk_2d_v2.so
	dolib.so ${libdir}/libnvddk_disp.so
	dolib.so ${libdir}/libnvddk_kbc.so
	dolib.so ${libdir}/libnvddk_mipihsi.so
	dolib.so ${libdir}/libnvddk_nand.so
	dolib.so ${libdir}/libnvddk_se.so
	dolib.so ${libdir}/libnvddk_snor.so
	dolib.so ${libdir}/libnvddk_spif.so
	dolib.so ${libdir}/libnvddk_usbphy.so
	dolib.so ${libdir}/libnvdispatch_helper.so
	dolib.so ${libdir}/libnvglsi.so
	dolib.so ${libdir}/libnvmedia_audio.so
	dolib.so ${libdir}/libnvmm_audio.so
	dolib.so ${libdir}/libnvmm_camera.so
	dolib.so ${libdir}/libnvmm_contentpipe.so
	dolib.so ${libdir}/libnvmm_image.so
	dolib.so ${libdir}/libnvmmlite_audio.so
	dolib.so ${libdir}/libnvmmlite_image.so
	dolib.so ${libdir}/libnvmmlite.so
	dolib.so ${libdir}/libnvmmlite_utils.so
	dolib.so ${libdir}/libnvmmlite_video.so
	dolib.so ${libdir}/libnvmm_manager.so
	dolib.so ${libdir}/libnvmm_parser.so
	dolib.so ${libdir}/libnvmm_service.so
	dolib.so ${libdir}/libnvmm.so
	dolib.so ${libdir}/libnvmm_utils.so
	dolib.so ${libdir}/libnvmm_video.so
	dolib.so ${libdir}/libnvmm_writer.so
	dolib.so ${libdir}/libnvodm_disp.so
	dolib.so ${libdir}/libnvodm_dtvtuner.so
	dolib.so ${libdir}/libnvodm_imager.so
	dolib.so ${libdir}/libnvodm_misc.so
	dolib.so ${libdir}/libnvodm_query.so
	dolib.so ${libdir}/libnvomxilclient.so
	dolib.so ${libdir}/libnvomx.so
	dolib.so ${libdir}/libnvos.so
	dolib.so ${libdir}/libnvparser.so
	dolib.so ${libdir}/libnvrm_graphics.so
	dolib.so ${libdir}/libnvrm.so
	dolib.so ${libdir}/libnvsm.so
	dolib.so ${libdir}/libnvtestio.so
	dolib.so ${libdir}/libnvtestresults.so
	dolib.so ${libdir}/libnvtvmr.so
	dolib.so ${libdir}/libnvwinsys.so
	dolib.so ${libdir}/libnvwsi.so

	# Note: since libjpeg.so do not has jpeg_mem_src and will make other packages
	#       build failed, we disable install it here
	dolib.so ${libdir}/libjpeg.so.${JPEG_ABI}
	dosym libjpeg.so.${JPEG_ABI} /usr/lib/libjpeg.so
}

pkg_preinst() {
		# Clean the dynamic libGLES stuff's home to ensure
	    # we dont have stale libs floating around
	    if [ -d "${ROOT}"/usr/lib/opengl/tegra3 ] ; then
			rm -rf "${ROOT}"/usr/lib/opengl/tegra3/*
	    fi
}

pkg_postinst() {

	# Switch to the tegra3 implementation
	use X && "${ROOT}"/usr/bin/eselect opengl set --use-old tegra3

	elog "You must be in the video group to use the NVIDIA Tegra3 device"
	elog "For more info, read the docs at"
	elog "http://www.gentoo.org/doc/en/nvidia-guide.xml#doc_chap3_sect6"
	elog
	elog "To use the NVIDIA Tegra3 GLX, run \"eselect opengl set tegra3\""
	elog
	if ! use X; then
		elog "You have elected to not install the X.org driver. Along with"
		elog "this the OpenGLES libraries were not installed."
		elog
	fi
}

pkg_prerm() {
	use X && "${ROOT}"/usr/bin/eselect opengl set --use-old xorg-x11
}

pkg_postrm() {
	use X && "${ROOT}"/usr/bin/eselect opengl set --use-old xorg-x11
}
