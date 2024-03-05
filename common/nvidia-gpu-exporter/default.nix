{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "nvidia_gpu_exporter";
  version = "v1.2.0";
  rev = "01f163635ca74aefcfb62cab4dc0d25cc26c0562";

  modSha245 = lib.fakeSha256;
  vendorHash = "sha256-6d6mMq2bG0D7Cd4ApRGAN+PM56wP+S0jOu09eucLCf8=";

  src = fetchFromGitHub {
    owner = "utkuozdemir";
    repo = "nvidia_gpu_exporter";
    rev = "${version}";
    hash =  "sha256-RS5vMh4R/BcrhW/azx+J8TOdLA6oZObQBe6bvUPpboQ=";

  };

  ldflags = [
    "-X github.com/utkuozdemir/nvidia_gpu_exporter.VERSION=${version}"
    "-X github.com/utkuozdemir/nvidia_gpu_exporter.GIT_COMMIT=${rev}"
  ];

  meta = with lib; {
    description = "Prometheus exporter that uses nvidia-smi";
    license = licenses.mit;
    homepage = "https://github.com/eutkuozdemir/nvidia_gpu_exporter";
    maintainers = with maintainers; [ utkuozdemir ];
  };
}
