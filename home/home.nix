{ config, lib, pkgs, stdenv, username, ... } :
let
  homeDirectory = "/home/${username}";

  defaultPkgs = with pkgs; [
    anki            # Spaced repetition flashcards
    bat             # A better `cat`
    brave           # Browser
    cloc            # Line counter
    htop            # Resource viewer
    keepassxc       # Password manager
    neovim          # Mid editor
    obsidian        # Note taker
    ripgrep         # A better `grep`
    tree            # File tree viewer
    xclip           # Clipboard/Terminal conduit
  ];
in
{
  programs.home-manager.enable = true;

  imports = builtins.concatMap import [
    ./programs
  ];

  home = {
    inherit username;
    inherit homeDirectory;

    packages = defaultPkgs;

    stateVersion = "23.05";
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
