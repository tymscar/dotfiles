{ config, pkgs, lib, ... }:

{
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      # list of possible plugins: https://github.com/NixNeovim/NixNeovimPlugins/blob/main/plugins.md
      plugins = with pkgs.vimExtraPlugins; [
        catppuccin
        Comment-nvim
        plenary-nvim
        nvim-tree-lua
        nvim-web-devicons
        lualine-nvim
        telescope-nvim
        nvim-cmp cmp-buffer cmp-path cmp-emoji cmp-nvim-lsp
        mason-nvim
        mason-lspconfig-nvim
        nvim-lspconfig
        lspsaga-nvim
        typescript-nvim
        lspkind-nvim
      ];
    };

    xdg.configFile."nvim/init.lua".source = ./config/init.lua;
    xdg.configFile."nvim/lua/colourscheme.lua".source = ./config/colourscheme.lua;
    xdg.configFile."nvim/lua/keymaps.lua".source = ./config/keymaps.lua;
    xdg.configFile."nvim/lua/settings.lua".source = ./config/settings.lua;
    xdg.configFile."nvim/lua/plugins/comment.lua".source = ./config/plugins/comment.lua;
    xdg.configFile."nvim/lua/plugins/nvim-tree.lua".source = ./config/plugins/nvim-tree.lua;
    xdg.configFile."nvim/lua/plugins/telescope.lua".source = ./config/plugins/telescope.lua;
    xdg.configFile."nvim/lua/plugins/lualine.lua".source = ./config/plugins/lualine.lua;
    xdg.configFile."nvim/lua/plugins/nvim-cmp.lua".source = ./config/plugins/nvim-cmp.lua;
    xdg.configFile."nvim/lua/plugins/lsp/mason.lua".source = ./config/plugins/lsp/mason.lua;
    xdg.configFile."nvim/lua/plugins/lsp/lspconfig.lua".source = ./config/plugins/lsp/lspconfig.lua;
    xdg.configFile."nvim/lua/plugins/lsp/lspsaga.lua".source = ./config/plugins/lsp/lspsaga.lua;
}
