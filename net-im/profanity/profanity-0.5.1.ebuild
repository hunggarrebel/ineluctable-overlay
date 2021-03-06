# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1
PYTHON_COMPAT=( python2_7 python3_{3,4,5,6} )
inherit autotools python-single-r1

DESCRIPTION="Profanity is a console based XMPP client inspired by irssi"
HOMEPAGE="http://profanity.im"
SRC_URI="https://github.com/boothj5/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86 ~arm"
IUSE="libnotify +otr +themes xscreensaver pgp test static-libs python plugins gtk"

REQUIRED_USE="python? ( plugins )"

CDEPEND="dev-libs/glib:2
	>=dev-libs/libstrophe-0.9.1[tls]
	net-misc/curl
	sys-apps/util-linux:0
	sys-libs/ncurses:0
	sys-libs/readline:0
	libnotify? ( x11-libs/libnotify )
	otr? ( net-libs/libotr )
	pgp? ( app-crypt/gpgme )
	xscreensaver? ( x11-libs/libXScrnSaver )"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	test? ( dev-util/cmocka )"
RDEPEND="${CDEPEND}
	${PYTHON_DEPS}
	libnotify? ( virtual/notification-daemon )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--disable-dependency-tracking
		$(use_enable libnotify notifications)
		$(use_enable otr)
		$(use_enable pgp)
		$(use_enable plugins)
		$(use_enable plugins c-plugins)
		$(use_enable python python-plugins)
		$(use_enable gtk icons)
		$(use_enable static-libs static)
		$(use_with themes)
		$(use_with xscreensaver)
	)
	econf "${myeconfargs[@]}"
}

pkg_postinst() {
	elog "Profanity User Guide is available online at the following URI:"
	elog "http://www.profanity.im/userguide.html"
}
