#!/bin/bash

SCRIPT_LOC=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
BINARY_LOC=out

rm -r $BINARY_LOC

cd $SCRIPT_LOC/virgil-lsp
bash build.sh
cd $SCRIPT_LOC
mkdir $BINARY_LOC
cp $SCRIPT_LOC/virgil-lsp/virgil-lsp $SCRIPT_LOC/$BINARY_LOC
