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

  cheat.sh-vim = pkgs.vimUtils.buildVimPlugin {
    name = "cheat.sh-vim";
    src = pkgs.fetchFromGitHub {
      owner = "dbeniamine";
      repo = "cheat.sh-vim";
      rev = "6f87a84c5006a2e6e0653505edb29fe18c0b8631";
      sha256 = "0n2kp5qir030f6pnd01zlxhy9mhh1157qikm7yx65513ww1p9n5g";
    };
  };
in {
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
    fzf
    ripgrep

    (vim_configurable.customize {
      name = "vim";
      vimrcConfig.customRC = builtins.readFile ./dotfiles/vim/vimrc;
      vimrcConfig.plug.plugins = with pkgs.vimPlugins; [
        Tabular
        cheat.sh-vim
        direnv-vim
        fzf-vim
        fzfWrapper
        goyo
        vim-commentary
        vim-dispatch
        vim-eunuch
        vim-godot
        vim-obsession
        vim-polyglot
        vim-surround
        vim-unimpaired
      ];
    })
  ];
}
