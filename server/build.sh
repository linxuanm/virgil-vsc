#!/bin/bash

V3C=${V3C:=$(which v3c)}
if [ ! -x "$V3C" ]; then
    echo "Virgil compiler (v3c) not found in \$PATH, and \$V3C not set"
    exit 1
fi

if [ "$VIRGIL_LIB" = "" ]; then
    if [ "$VIRGIL_LOC" = "" ]; then
        V3C_LOC=$(dirname $(which v3c))
        VIRGIL_LOC=$(cd $V3C_LOC/../ && pwd)
    fi
    VIRGIL_LIB=${VIRGIL_LOC}/lib/
fi

if [ ! -e "$VIRGIL_LIB/util/Vector.v3" ]; then
    echo "Virgil library code not found (searched $VIRGIL_LIB)."
    echo "Please set either: "
    echo "  VIRGIL_LOC, to the root of your Virgil installation"
    echo "  VIRGIL_LIB, to point directly to root of the library"
    exit 1
fi

SRC_PATH="src"
LIB_PATH="libs"

RAW_COMPILER_SRC=""
COMPILER_SRC=$(echo "$RAW_COMPILER_SRC" | tr '\n' ' ')

V3_LIBS="$VIRGIL_LIB/util/*.v3"
MAIN="$SRC_PATH/main.v3"

SOURCES="$V3_LIBS $COMPILER_SRC $MAIN"

$V3C $SOURCES
