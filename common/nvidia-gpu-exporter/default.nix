{
  pkgs ? import (fetchTarball {
    url = "https://github.com/utkuozdemir/nvidia_gpu_exporter/releases/download/v1.2.0/nvidia_gpu_exporter_1.2.0_linux_x86_64.tar.gz";
    sha256 = "0qff1yxza9lmszchxx484bc06mni0014p1apbv1zh2ips22jkwif";
  }) {}
}:
pkgs.stdenv.mkDerivation rec {
  pname = "nvidia-gpu-exporter";
  version = "1.2.0";

  installPhase = ''
    ls $src
    mkdir -p $out/bin
    #mv chord $out/bin
  '';
}
{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "dstask";
  version = "v1.2.0";
  rev = "d687a0f9aec634a808cfa0df4aecb06ab4f57732";

  subPackages = [ "cmd/dstask.go" ];

  src = fetchFromGitHub {
    owner = "naggie";
    repo = "dstask";
    rev = "${version}";
    sha256 = "16z5zlfj955pzsj0l58835slvpchdaq2vbyx2fjzi6y9xn1z2nd1";
  };

  modSha256 = "1ydzqg8p2d514sdb34b2p6k1474nr1drrn3gay2cpyhrj5l51cj3";

  buildFlagsArray = [ ''-ldflags=-w -s
    -X "github.com/naggie/dstask.VERSION=${version}"
    -X "github.com/naggie/dstask.GIT_COMMIT=${rev}"
  '' ];

  meta = with lib; {
    description = "A personal task tracker designed to help you focus";
    license = licenses.mit;
    homepage = "https://github.com/naggie/dstask";
    maintainers = with maintainers; [ foxit64 ];
  };

}
