{
  description = "ms dotfiles: nix-darwin + home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Agent skill sources, pinned in flake.lock; `nix flake update` updates them
    mattpocock-skills = { url = "github:mattpocock/skills"; flake = false; };
    anthropic-skills = { url = "github:anthropics/skills"; flake = false; };
    jeffallan-skills = { url = "github:jeffallan/claude-skills"; flake = false; };
    vercel-skills = { url = "github:vercel-labs/skills"; flake = false; };
    orca = { url = "github:stablyai/orca"; flake = false; };
  };

  outputs = inputs@{ nix-darwin, home-manager, ... }: {
    darwinConfigurations.mbp = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            # Existing files are moved aside instead of blocking activation
            backupFileExtension = "before-hm";
            extraSpecialArgs = { inherit inputs; };
            users.ms = import ./home.nix;
          };
        }
      ];
    };
  };
}
