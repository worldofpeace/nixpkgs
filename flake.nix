{
  name = "nixpkgs";

  epoch = 201906;

  description = "A collection of packages for the Nix package manager";

  outputs = inputs:
    let pkgs = import ./. { system = "x86_64-linux"; }; in
    {
      lib = (import ./lib) // {
        nixosSystem = import ./nixos/lib/eval-config.nix;
      };

      checks.tarball = (import ./pkgs/top-level/release.nix {
        nixpkgs = inputs.self;
      }).tarball;

      builders = {
        inherit (pkgs) stdenv fetchurl;
      };

      packages = {
        inherit (pkgs) hello nix fuse nlohmann_json boost firefox;
      };

      legacyPackages = pkgs;
    };
}
