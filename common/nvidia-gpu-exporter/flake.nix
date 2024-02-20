{ pkgs }:

let
  hello = pkgs.stdenv.mkDerivation rec {
    pname = "hello";
    version = "1.2.0";
    src = pkgs.fetchurl {
      url = "https://github.com/utkuozdemir/nvidia_gpu_exporter/releases/download/v${version}/nvidia_gpu_exporter_${version}_linux_x86_64.tar.gz";
      sha256 = "0qff1yxza9lmszchxx484bc06mni0014p1apbv1zh2ips22jkwif";
    };
  };
in {
  deps = [
    hello
  ];
}
