# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="WebSocket/WAMP protocol implementation for Python/Twisted"
HOMEPAGE="http://pypi.python.org/pypi/autobahn http://autobahn.ws/developers"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/setuptools
	>=dev-python/twisted-11.0.0"
DEPEND="app-arch/unzip
	dev-python/setuptools"
