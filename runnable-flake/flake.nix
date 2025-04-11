{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      apps.${system}.default =
        let
          serv = pkgs.writeShellApplication {
            # Our shell script name is serve
            # so it is available at $out/bin/serve
            name = "serve";
            # Caddy is a web server with a convenient CLI interface
            runtimeInputs = [ pkgs.caddy ];
            text = ''
              # Serve the current directory on port 8090
              caddy file-server --listen :8090 --root .
            '';
          };
        in
        {
          type = "app";
          # Using a derivation in here gets replaced
          # with the path to the built output
          program = "${serv}/bin/serve";
        };
    };
}
