{
  description = "Home Manager configuration of eric";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = { url = "github:oxalica/rust-overlay"; inputs.nixpkgs.follows = "nixpkgs"; };
  };
  outputs = { nixpkgs, home-manager, rust-overlay, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64";
      pkgs = import nixpkgs { 
        inherit system; 
        overlays = [ rust-overlay.overlays.default ]; 
      };
    in {
      homeConfigurations = {
        eric = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ # incldues home manager config
            ./home.nix 
          ];
        };
      };
    };
}
