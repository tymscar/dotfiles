{ config, pkgs, lib, ... }:

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
  };

in
{
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      fd
      gccgo
      lua-language-server
      nodePackages.typescript
      nodePackages.typescript-language-server
      nil
      code-minimap
    ];

    # list of possible plugins: https://github.com/NixNeovim/NixNeovimPlugins/blob/main/plugins.md
    plugins = with pkgs.vimExtraPlugins; with pkgs.vimPlugins; [
      catppuccin
      Comment-nvim
      plenary-nvim
      nvim-tree-lua
      nvim-web-devicons
      lualine-nvim
      telescope-nvim
      which-key-nvim
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      LuaSnip
      cmp-luasnip
      neodev-nvim
      nvim-treesitter.withAllGrammars
      minimap-vim
    ];
  };

  xdg.configFile = configFileMap;
}
