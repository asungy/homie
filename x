#!/usr/bin/env bash

# Nix helper build script.

# Shows the output of every command.
set +x
# Abort on any command failures.
set -e

activateHM() {
    result/activate
}

rebuild_home() {
    nix build --extra-experimental-features nix-command --extra-experimental-features flakes .#homeConfigurations.asungy.activationPackage
    activateHM
}

main() {
    case $1 in
        "home")
            rebuild_home;;
        *)
            echo 'Expected "home".';;
    esac
}

main "$@" || exit 1
