{ pkgs, ... }:

let
  vim-beelzebub = pkgs.vimUtils.buildVimPlugin {
    name = "vim-beelzebub";
    src = pkgs.fetchFromGitHub {
      owner = "xdefrag";
      repo = "vim-beelzebub";
      rev = "55393041be725c626ea5be9b9a8dba322255467d";
      sha256 = "0w76w9s6cwfl7mmgx9sldi535agg6q56g32aw0bggjh9i176gxih";
    };
  };
in {
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs;
    [
      ((vim_configurable.override { python = python3; }).customize {
        name = "vim";
        vimrcConfig.customRC = builtins.readFile ./dotfiles/vimrc;
        vimrcConfig.plug.plugins = with pkgs.vimPlugins; [
          fugitive
          fzf-vim
          fzfWrapper
          ultisnips
          vim-beelzebub
          vim-commentary
          vim-dispatch
          vim-eunuch
          vim-gitgutter
          vim-polyglot
          vim-repeat
          vim-snippets
          vim-surround
          vim-unimpaired
        ];
      })
    ];
}
