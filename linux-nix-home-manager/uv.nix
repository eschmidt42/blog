{ pkgs, lib, ... }:
let
  rustToolchain = pkgs.rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" ];
  };
  uvPackage = pkgs.rustPlatform.buildRustPackage rec {
      pname = "uv";
      version = "0.5.7"; # update

      src = pkgs.fetchFromGitHub {
        owner = "astral-sh";
        repo = "uv";
        # Replace with the desired commit hash
        rev = "3ca155d";
        # You need to update this hash when changing the rev
        hash = "sha256-kQiML3AjVx9W8u6sN0l6btpx1rkGmlWpSV4Uc7f1WIk=";
        #hash = lib.fakeHash; # to find out the hash
      };
      cargoLock.lockFile = src + "/Cargo.lock";
      cargoLock.outputHashes = {
         "async_zip-0.0.17" = "sha256-VfQg2ZY5F2cFoYQZrtf2DHj0lWgivZtFaFJKZ4oyYdo=";
         #"async_zip-0.0.17" = lib.fakeHash;
         "pubgrub-0.2.1" = "sha256-zusQxYdoNnriUn8JCk5TAW/nQG7fwxksz0GBKEgEHKc=";
         #"pubgrub-0.2.1" = lib.fakeHash;
         "tl-0.7.8" = "sha256-F06zVeSZA4adT6AzLzz1i9uxpI1b8P1h+05fFfjm3GQ=";
         #"tl-0.7.8" = lib.fakeHash;
       };

      #cargoHash = lib.fakeHash; # "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";

      nativeBuildInputs = [ 
        pkgs.pkg-config 
        rustToolchain 
        pkgs.cmake
      ];
      buildInputs = with pkgs; [ openssl darwin.apple_sdk.frameworks.Security ];
      RUSTC = "${rustToolchain}/bin/rustc";
      CARGO = "${rustToolchain}/bin/cargo";
      
      doCheck = false; # tests might require additional setup and thus fail
      meta = with lib; {
        description = "An extremely fast Python package installer and resolver";
        homepage = "https://github.com/astral-sh/uv";
        license = licenses.asl20; # https://github.com/NixOS/nixpkgs/blob/master/lib/licenses.nix
        maintainers = with maintainers; [ ];
      };
    };
  in
{
  home.packages = [ uvPackage ];
}
