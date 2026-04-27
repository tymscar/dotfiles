{ pkgs, ... }:

let

  configFileMap = {
    "nvim/init.lua".source = ./config/init.lua;
    "nvim/lua/colourscheme.lua".source = ./config/colourscheme.lua;
    "nvim/lua/keymaps.lua".source = ./config/keymaps.lua;
    "nvim/lua/settings.lua".source = ./config/settings.lua;
    "nvim/lua/plugins/comment.lua".source = ./config/plugins/comment.lua;
    "nvim/lua/plugins/nvim-tree.lua".source = ./config/plugins/nvim-tree.lua;
    "nvim/lua/plugins/telescope.lua".source = ./config/plugins/telescope.lua;
    "nvim/lua/plugins/lualine.lua".source = ./config/plugins/lualine.lua;
    "nvim/lua/plugins/whichkey.lua".source = ./config/plugins/whichkey.lua;
    "nvim/lua/plugins/lsp.lua".source = ./config/plugins/lsp.lua;
    "nvim/lua/plugins/cmp.lua".source = ./config/plugins/cmp.lua;
    "nvim/lua/plugins/treesitter.lua".source = ./config/plugins/treesitter.lua;
    "nvim/lua/plugins/gitsigns.lua".source = ./config/plugins/gitsigns.lua;
    "nvim/lua/plugins/neogit.lua".source = ./config/plugins/neogit.lua;
  };

in
{
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withRuby = true;

    extraPackages = with pkgs; [
      code-minimap
      fd
      ripgrep
      lua-language-server
      nil
      rust-analyzer
      clippy
      typescript
      typescript-language-server
      kotlin-language-server
      gopls
      gleam
      bash-language-server
    ];

    # list of possible plugins: https://github.com/NixNeovim/NixNeovimPlugins/blob/main/plugins.md
    plugins =
      with pkgs.vimExtraPlugins;
      with pkgs.vimPlugins;
      [
        comment-nvim
        diffview-nvim
        luasnip
        cmp-buffer
        cmp_luasnip
        cmp-nvim-lsp
        cmp-path
        gitsigns-nvim
        lualine-nvim
        minimap-vim
        neodev-nvim
        neogit
        nvim-cmp
        nvim-lspconfig
        nvim-tree-lua
        (nvim-treesitter.withPlugins (plugins: with plugins; [
          tree-sitter-bash
          tree-sitter-go
          tree-sitter-json
          tree-sitter-kotlin
          tree-sitter-lua
          tree-sitter-markdown
          tree-sitter-nix
          tree-sitter-rust
          tree-sitter-typescript
          tree-sitter-yaml
        ]))
        nvim-web-devicons
        plenary-nvim
        telescope-nvim
        telescope-ui-select-nvim
        which-key-nvim
      ];
  };

  xdg.configFile = configFileMap;
}
