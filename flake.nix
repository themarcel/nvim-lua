{
  description = "Marcel's Neovim Config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    let
      neovimTools =
        pkgs: with pkgs; [
          luajit
          lua-language-server
          nodePackages_latest.vscode-json-languageserver
          stylua
          luarocks
          readline
          fzf
          fd
          ripgrep
          bat
        ];
    in
    {
      homeManagerModules.default =
        {
          config,
          lib,
          pkgs,
          ...
        }:
        {
          config.programs.neovim.enable = true;
          config.programs.neovim.extraPackages = neovimTools pkgs;
          config.xdg.configFile."nvim".source = ./.;
        };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = neovimTools pkgs;
          shellHook = ''
            echo "Lua shell on ${pkgs.luajit.version} – happy vim!"
          '';
        };
      }
    );
}
