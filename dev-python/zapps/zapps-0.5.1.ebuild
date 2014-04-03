# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )
inherit distutils-r1

DESCRIPTION="A book compiler for programmers where code and prose are separate (a Yapps fork)."
HOMEPAGE="http://pypi.python.org/pypi/${PN}"
SRC_URI="http://www.dexy.it/external-dependencies/${P}.tar.gz"

LICENSE="HPND"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DOCS="NOTES"