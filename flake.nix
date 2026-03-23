{
  description = "Marcel's Neovim Config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
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
          # Core
          luajit
          lua54Packages.luarocks-nix
          lua51Packages.lua
          lua-language-server
          luarocks
          readline
          fzf
          fd
          ripgrep
          bat
          tree-sitter
          gcc

          # VSCode Language Servers (JSON, CSS, HTML, ESLint)
          vscode-langservers-extracted

          # LSP Servers
          astro-language-server
          bash-language-server
          clang-tools
          elixir-ls
          fennel-ls
          marksman
          markdown-oxide
          nil
          python3Packages.python-lsp-server
          rust-analyzer
          taplo
          typescript-language-server
          vale-ls
          mdx-language-server

          # Formatters
          alejandra
          biome
          python3Packages.black
          cbfmt
          deno
          dprint
          eslint_d
          fixjson
          python3Packages.isort
          oxlint
          nodePackages.prettier
          prettierd
          rustfmt
          shfmt
          stylua
          # tombi not available in nixpkgs
          xmlformat

          # Debuggers
          delve
          vscode-extensions.vadimcn.vscode-lldb

          # CLI Tools
          lazygit
          tig
          gcc
          gnumake
          cargo
          direnv
          nodejs_25
          yarn
          docker
          difftastic
          util-linux
          coreutils
          curl
          bash
          findutils
          zoxide
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
