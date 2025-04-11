let
  pkgs =
    import
      (fetchTarball "https://github.com/NixOS/nixpkgs/archive/0b20bf89e0035b6d62ad58f9db8fdbc99c2b01e8.tar.gz")
      { };
in
pkgs.stdenv.mkDerivation {
  src = ./rust-hello;
  name = "rust-hello-1.0";
  system = "x86_64-linux";
  nativeBuildInputs = [ pkgs.cargo ];
  buildPhase = ''
    cargo build --release
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp target/release/rust-hello $out/bin/rust-hello
    chmod +x $out
  '';
}
