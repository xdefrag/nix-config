{ pkgs, ... }:

let
  vim-godot = pkgs.vimUtils.buildVimPlugin {
    name = "vim-godot";
    src = pkgs.fetchFromGitHub {
      owner = "habamax";
      repo = "vim-godot";
      rev = "8fd5bbdc3dcc9eacfccfce83456912d62235e6fc";
      sha256 = "0gkjzhm19ajagkxwh83b8kdpp1kmcnan0n1lppkb2937j3r9s37a";
    };
  };
in {
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
    ripgrep

    (vim_configurable.customize {
      name = "vim";
      vimrcConfig.customRC = builtins.readFile ./dotfiles/vim/vimrc;
      vimrcConfig.plug.plugins = with pkgs.vimPlugins; [
        direnv-vim
        fzf-vim
        fzfWrapper
        goyo
        vim-commentary
        vim-dispatch
        vim-eunuch
        vim-godot
        vim-lsc
        vim-obsession
        vim-polyglot
        vim-surround
        vim-unimpaired
      ];
    })
  ];
}
