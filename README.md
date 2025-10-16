# WonkoOS-temp

Eventually this will get promoted to not temp status. Maybe. :-P

nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount --flake github:bhechinger/WonkoOS-temp#deepthought

nixos-install --no-write-lock-file --root /mnt --flake github:bhechinger/WonkoOS-temp#deepthought
