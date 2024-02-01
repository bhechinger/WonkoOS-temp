{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains.goland
    jetbrains.idea-ultimate
    jetbrains.gateway
    jetbrains.datagrip
    jetbrains.clion
    jetbrains.rust-rover
    fira-code
    gh
    glab
    kubernetes-helm
    kubectl
    krew
    kustomize
    awscli2
    python3
    gdb
    lldb
    gcc
    rustup
    minikube
    kubernetes-helm
    cilium-cli
  ];
}
