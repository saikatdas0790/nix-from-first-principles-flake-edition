let
  pkgs =
    import
      (fetchTarball "https://github.com/NixOS/nixpkgs/archive/0b20bf89e0035b6d62ad58f9db8fdbc99c2b01e8.tar.gz")
      { };
in
pkgs.stdenv.mkDerivation {
  src = ./hello.sh;
  name = "hello-1.0";
  system = "x86_64-linux";
  dontUnpack = true;
  installPhase = ''
    cp $src $out
    chmod +x $out
  '';
}
