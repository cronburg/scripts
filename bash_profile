#!/bin/bash
[ -e $HOME/.bashrc ] && source $HOME/.bashrc

# OPAM configuration
[ -e $HOME/.opam/ ] && . $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

