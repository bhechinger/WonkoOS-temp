{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vscode
    vscode-extensions.golang.go
    vscode-extensions.sumneko.lua
    vscode-extensions.mkhl.direnv
    vscode-extensions.bbenoist.nix
    vscode-extensions.vscodevim.vim
    vscode-extensions.xyz.local-history
    vscode-extensions.waderyan.gitblame
    vscode-extensions.jnoortheen.nix-ide
    vscode-extensions.irongeek.vscode-env
    vscode-extensions.hashicorp.terraform
    vscode-extensions.bungcip.better-toml
    vscode-extensions.zxh404.vscode-proto3
    vscode-extensions.timonwong.shellcheck
    vscode-extensions.tabnine.tabnine-vscode
    vscode-extensions.oderwat.indent-rainbow
    vscode-extensions.codezombiech.gitignore
    vscode-extensions.rust-lang.rust-analyzer
    vscode-extensions.donjayamanne.githistory
  ];
}
