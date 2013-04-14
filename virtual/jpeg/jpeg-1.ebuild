# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jpeg/jpeg-0.ebuild,v 1.10 2013/02/18 01:06:08 zmedico Exp $

EAPI=4

DESCRIPTION="A virtual for the JPEG implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="arm ~arm"
IUSE="static-libs"

RDEPEND="|| (
		>=media-libs/libjpeg-turbo-1.2.0:0[static-libs?]
		>=media-libs/jpeg-8d:0[static-libs?]
		x11-drivers/tegra3-driver
		)"
DEPEND=""
