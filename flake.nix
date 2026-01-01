{
  description = "Cross-platform shared clipboard";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      allSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs allSystems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          uniclip = pkgs.buildGoModule {
            name = "uniclip";
            src = ./.;
            vendorHash = "sha256-ugrWrB0YVs/oWAR3TC3bEpt1VXQC1c3oLrvFJxlR8pw=";
            
            meta = with pkgs.lib; {
              description = "Cross-platform shared clipboard";
              homepage = "https://github.com/quackduck/uniclip";
              license = licenses.mit;
              platforms = [ pkgs.stdenv.hostPlatform.system ];
              mainProgram = "uniclip";
            };
          };

          default = self.packages.${system}.uniclip;
        });

      defaultPackage = forAllSystems (system: self.packages.${system}.default);
    };
}
