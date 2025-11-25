{
  description = "Home Manager plus hyprland config";

  nixConfig = {
      # 1. Add the Cachix URL to your substituters
      extra-substituters = [
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
          # Add other Cachix URLs here if needed
        ];
        # 2. Add the public key to trust the cache
        extra-trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          # Add other keys here
        ];
      };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
	  #pkgs = nixpkgs.legacyPackages.${system};
	  pkgs = import nixpkgs {
		inherit system;
		config = {
		  allowUnfree = true; # Set the configuration here
		};
	  };
    in
    {
      homeConfigurations."aaditya" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
		  ./home.nix
		];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
