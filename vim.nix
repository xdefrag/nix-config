{ pkgs, ... }:

{
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs;
    [
      (vim_configurable.customize {
        name = "vim";
        vimrcConfig.customRC = builtins.readFile ./dotfiles/vim/vimrc;
        vimrcConfig.plug.plugins = with pkgs.vimPlugins; [
          neosnippet
          neosnippet-snippets
          vim-commentary
          vim-dispatch
          vim-eunuch
          vim-polyglot
          vim-surround
          vim-unimpaired
        ];
      })
    ];
}
