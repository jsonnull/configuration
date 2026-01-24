{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
let
  cfg = config.tools.nixcats;
in
{
  imports = [ inputs.nixCats.homeModule ];

  options.tools.nixcats.enable = lib.mkEnableOption "Enable nixCats";

  config = lib.mkIf cfg.enable {
    nixCats = {
      enable = true;
      packageNames = [ "ncats" ];
      luaPath = "${./.}";

      categoryDefinitions.replace = { pkgs, ... }: {
        lspsAndRuntimeDeps = {
          general = with pkgs; [
            ripgrep
            fd
          ];
          lsp = with pkgs; [
            bash-language-server
            vscode-langservers-extracted # cssls, html, jsonls, eslint
            lua-language-server
            nil # Nix LSP
            nixfmt-rfc-style # nil_ls formatting
            svelte-language-server
            yaml-language-server
            rust-analyzer
          ];
        };

        # Plugins that load immediately at startup
        startupPlugins = {
          general = with pkgs.vimPlugins; [
            # Core dependencies
            plenary-nvim
            nvim-web-devicons

            # Lazy loader
            lze

            # UI (always visible)
            lualine-nvim
            bufferline-nvim
            vim-startify

            # Git (signs in gutter)
            gitsigns-nvim

            # Snacks (has startup features)
            snacks-nvim

            # Session management (needs early load)
            auto-session

            # Treesitter (startup for folding/highlighting)
            (nvim-treesitter.withPlugins (p: [
              p.bash
              p.javascript
              p.json
              p.lua
              p.make
              p.markdown
              p.nix
              p.regex
              p.svelte
              p.toml
              p.tsx
              p.typescript
              p.vim
              p.vimdoc
              p.xml
              p.yaml
            ]))
            nvim-treesitter-textobjects
          ];
        };

        # Plugins that load on-demand
        optionalPlugins = {
          general = with pkgs.vimPlugins; [
            # File explorer
            nvim-tree-lua

            # Editing
            mini-nvim

            # Utilities
            which-key-nvim
            bufdelete-nvim

            # LSP
            nvim-lspconfig
            typescript-tools-nvim
          ];
        };
      };

      packageDefinitions.replace = {
        ncats = { pkgs, ... }: {
          settings = {
            wrapRc = true;
            # No aliases - keeps nvim/vim pointing to nixvim
          };
          categories = {
            general = true;
            lsp = true;
          };
        };
      };
    };
  };
}
