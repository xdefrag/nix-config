{ pkgs, ... }:

{
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
    ((vim_configurable.override {}).customize {
      name = "vim";
      vimrcConfig.customRC = builtins.readFile ./dotfiles/vimrc;
      vimrcConfig.plug.plugins = with pkgs.vimPlugins; [
        neosnippet
        neosnippet-snippets
        vim-commentary
        vim-dispatch
        vim-polyglot
        vim-surround
        vim-unimpaired
      ];
    })
  ];
}
