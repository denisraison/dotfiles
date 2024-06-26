{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, ... }:
    flake-utils.lib.eachSystem ([ "x86_64-linux" ]) (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        mkUser = user:
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ (./. + "/users/${user}/default.nix") ];
            extraSpecialArgs = { inherit self; };
          };
      in {
        formatter = pkgs.nixfmt-classic;
        packages = { homeConfigurations.raison = mkUser "raison"; };
      });
}
