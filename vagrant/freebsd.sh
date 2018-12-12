#!/bin/sh

setup() {
    pkg install --yes autoconf \
        automake \
        boost-libs \
        git \
        gmake \
        libevent \
        libtool \
        openssl \
        pkgconf \
        python3
    
    cd /home/bitcoin
    ./contrib/install_db4.sh `pwd`
}

compile() {
    export BDB_PREFIX=/home/bitcoin/db4

    cd /home/bitcoin
    git clean -fx
    git status
    ./autogen.sh
    ./configure --with-gui=no \
        BDB_LIBS="-L${BDB_PREFIX}/lib -ldb_cxx-4.8" \
        BDB_CFLAGS="-I${BDB_PREFIX}/include"
    gmake check
}

case $1 in
	setup)
		setup
	;;
	compile)
        compile
	;;
	*)
	    echo "Usage: freebsd.sh setup|compile"
	;;
esac
