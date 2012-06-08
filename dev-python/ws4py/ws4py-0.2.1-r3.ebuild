# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ws4py/ws4py-0.2.1-r2.ebuild,v 1.1 2012/04/24 02:31:04 vapier Exp $

# We could depend on dev-python/cherrypy when USE=server, but
# that is an optional component ...
# Same for www-servers/tornado and USE=client ...

EAPI="4"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://github.com/Lawouach/WebSocket-for-Python.git"
	inherit git-2
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Lawouach/WebSocket-for-Python/tarball/v${PV} -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

DESCRIPTION="WebSocket support for Python"
HOMEPAGE="https://github.com/Lawouach/WebSocket-for-Python"

LICENSE="BSD"
SLOT="0"
IUSE="+client +server +threads"

RDEPEND="client? ( dev-lang/python[threads?] )
	dev-python/gevent"
# one-of-many for server???
DEPEND="
	test? (
		dev-python/authobahntestsuite
		dev-python/cherrypy
		www-servers/tornado
		${RDEPEND}
	)
"

src_prepare() {
	epatch "${FILESDIR}"/${P}-process-data.patch
	distutils_src_prepare
}

# Figure out how to run them...
#src_test() {
#	cd test
#   python autobahn_test_servers.py --run-all
#   wstest -m fuzzingclient -s fuzzingclient.json
#}

src_install() {
	distutils_src_install
	use client || rm -rf "${ED}$(python_get_sitedir)"/ws4py/client
	use server || rm -rf "${ED}$(python_get_sitedir)"/ws4py/server
}
