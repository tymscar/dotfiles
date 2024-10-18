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
    "nvim/lua/plugins/toggleterm.lua".source = ./config/plugins/toggleterm.lua;
    "nvim/lua/plugins/alpha.lua".source = ./config/plugins/alpha.lua;
  };

in {
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      code-minimap
      fd
      lua-language-server
      nil
      rust-analyzer
      clippy
      nodePackages.typescript
      nodePackages.typescript-language-server
    ];

    # list of possible plugins: https://github.com/NixNeovim/NixNeovimPlugins/blob/main/plugins.md
    plugins = with pkgs.vimExtraPlugins;
      with pkgs.vimPlugins; [
        Comment-nvim
        LuaSnip
        alpha-nvim
        cmp-luasnip
        cmp-nvim-lsp
        # copilot-vim
        dracula-nvim
        lualine-nvim
        minimap-vim
        neodev-nvim
        nvim-cmp
        nvim-lspconfig
        nvim-tree-lua
        nvim-treesitter.withAllGrammars
        nvim-web-devicons
        plenary-nvim
        telescope-nvim
        toggleterm-nvim
        which-key-nvim
      ];
  };

  xdg.configFile = configFileMap;
}
