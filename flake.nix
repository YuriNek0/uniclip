{
  description = "Cross-platform shared clipboard";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system: let
    pkgs = nixpkgs.legacyPackages.${system};
  in rec {
    packages.uniclip = pkgs.buildGoModule {
      name = "uniclip";
      src = ./.;
      vendorHash = "sha256-ugrWrB0YVs/oWAR3TC3bEpt1VXQC1c3oLrvFJxlR8pw=";
      meta = with pkgs.lib; {
        description = "Cross-platform shared clipboard";
        homepage = "https://github.com/quackduck/uniclip";
        license = licenses.mit;
        platforms = platforms.linux ++ platforms.darwin;
      };
    };
    defaultPackage = packages.uniclip;
  });
}
