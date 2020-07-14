{ pkgs, ... }:

{
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs;
  [
      ((vim_configurable.override { python = python3; }).customize {
        name = "vim";
        vimrcConfig.customRC = builtins.readFile ./dotfiles/vimrc;
        vimrcConfig.plug.plugins = with pkgs.vimPlugins; [
          auto-pairs
          fugitive
          fzf-vim
          fzfWrapper
          supertab
          ultisnips
          vim-commentary
          vim-dispatch
          vim-eunuch
          vim-gitgutter
          vim-polyglot
          vim-repeat
          vim-snippets
          vim-surround
          vim-unimpaired
          wal-vim
        ];
      })
    ];
}
