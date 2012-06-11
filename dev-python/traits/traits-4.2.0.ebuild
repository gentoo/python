# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traits/traits-4.1.0.ebuild,v 1.3 2012/06/01 13:02:22 ago Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Enthought Tool Suite: Explicitly typed attributes for Python"
HOMEPAGE="http://code.enthought.com/projects/traits/ http://pypi.python.org/pypi/traits"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc examples test"

RDEPEND="dev-python/numpy"
DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )
	test? ( dev-python/numpy )"

DOCS="docs/*.txt"
PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_prepare() {
	sed -i -e "s/'-O3'//g" setup.py || die
	find -name "*LICENSE*.txt" -delete
}

src_compile() {
	distutils_src_compile
	if use doc ; then
		pushd docs &> /dev/null
		PYTHONPATH="$(ls -d ../build-$(PYTHON -f --ABI)/lib.*)" sphinx-build -b	html -d build/doctrees source build/html
		popd &> /dev/null
	fi
}

src_test() {
	testing() {
		nosetests -P -s $(ls -d build-${PYTHON_ABI}/lib*) -v
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -rf "${ED}$(python_get_sitedir)/${PN}/tests"
	}
	python_execute_function -q delete_tests

	use doc && dohtml -r docs/build/html/*

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
