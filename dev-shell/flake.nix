{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      # A list of shell names and their Python versions
      pythonVersions = {
        python38 = pkgs.python38;
        python39 = pkgs.python39;
        python310 = pkgs.python310;
        default = pkgs.python310;
      };
      # A function to make a shell with a python version
      makePythonShell =
        shellName: pythonPackage:
        pkgs.mkShell {
          # You could add extra packages you need here too
          packages = [ pythonPackage ];
          # You can also add commands that run on shell startup with shellHook
          shellHook = ''
            echo "Now entering ${shellName} environment."
          '';
        };
    in
    {
      # mapAttrs runs the given function (makePythonShell) against every value
      # in the attribute set (pythonVersions) and returns a new set
      devShells.x86_64-linux = builtins.mapAttrs makePythonShell pythonVersions;
    };
}
