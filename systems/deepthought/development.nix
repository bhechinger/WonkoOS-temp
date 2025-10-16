{ pkgs, pkgs-brian, ... }:

{
  environment.systemPackages = with pkgs; [
    fira-code
    gh
    #glab
    #kubernetes-helm
    #kubectl
    #kubeswitch
    #krew
    #kustomize
    #gdb
    #lldb
    #gcc
    #autoconf
    #automake
    #rustup
    #minikube
    #kind
    #kubernetes-helm
    #cilium-cli
    #chart-testing
    #google-cloud-sdk-gce
    #(google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
    #k9s
    #kube-capacity
    #action-validator
    #act
    #argocd
    #pkgs-brian.ops
    #go
    #podman
    #podman-compose
    #zellij
    #libxslt
    #graphviz
    #grpcurl
  ];
}
