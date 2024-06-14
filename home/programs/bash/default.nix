# Reference: https://github.com/nix-community/home-manager/blob/master/modules/programs/bash.nix
{ pkgs, ... } :
let
  shellAliases = {
    archbox = "docker run --network=host -it --rm --name=archbox archlinux:latest /bin/bash";
    archbox-mnt = (
      "docker run --network=host -it --rm " +
      "--name=archbox-mnt " +
      "--workdir=/mnt/\"\$\{PWD##*/}\" " +
      "--volume=\"\$(pwd)\":/mnt/\"\$\{PWD##*/}\" " +
      "archlinux:latest /bin/bash"
    );
    cpwd = "pwd | xclip -selection clipboard";
    ls = "ls --color=tty";
    li = "ls --color=tty"; # easier typing for dvorak
    vim = "nix run github:asungy/xvim";
    acvpn = "/opt/anyconnect-linux64-4.9.06037/vpn/vpn";
    alacritty-bash = "alacritty --option 'shell.program=\"/usr/bin/bash\"'";
  };

  sessionVariables = {};
in
{
  programs.bash = {
    inherit shellAliases sessionVariables;

    enable = true;
    enableCompletion = true;
    initExtra = builtins.readFile ./rc.sh;
  };
}
