# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit multilib flag-o-matic

DESCRIPTION="HOARD Memory Allocator"
HOMEPAGE="http://www.hoard.org"
SRC_URI="https://github.com/emeryberger/Hoard/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc debug"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/emeryberger-Hoard-d065953"

src_compile() {
	# Makefile forces hardcode -march cflags (pentium4 and nocona), so we
	# need to substitue these values with the one supplied by the user into
	# the make.conf.
	# NOTE: this is necessary to avoid binary breakage and to fix runtime text
	# relocations too
	sed -i \
		-e "s:-march=pentium4:-march=$(get-flag march) -fPIC:" \
		-e "s:-march=nocona:-march=$(get-flag march) -fPIC:" \
		src/Makefile || die "seding src/Makefile failed."

	local target
	case ${ARCH} in
	x86*)
		target="linux-gcc-x86"
		;;
	amd64)
		target="linux-gcc-x86-64"
		;;
	*)
		target="generic-gcc"
		;;
	esac

	use debug && target="${target}-debug"
	cd src/
	emake ${target} || die "emake failed."
}

src_install() {
	# installing env.d
	cat <<EOF > "${T}"/01hoard
LD_PRELOAD=/usr/$(get_libdir)/libhoard.so
EOF
	doenvd "${T}"/01hoard

	# installing libhoard
	dolib.so src/libhoard.so

	# installing docs
	dodoc {AUTHORS,COPYING,NEWS,README,THANKS}
	if use doc; then
		dohtml -r doc/*
	fi
}
