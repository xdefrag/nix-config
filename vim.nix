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
  vim-qlist = pkgs.vimUtils.buildVimPlugin {
    name = "vim-qlist";
    src = pkgs.fetchFromGitHub {
      owner = "romainl";
      repo = "vim-qlist";
      rev = "be8fba124bf13314435b1faab8f628436d4cffb1";
      sha256 = "0ska2mzx3hqqkq3fd09r0hlk2j8xc8mbbwfky31x3cmzsb9dksqw";
    };
  };
  vim-qf = pkgs.vimUtils.buildVimPlugin {
    name = "vim-qf";
    src = pkgs.fetchFromGitHub {
      owner = "romainl";
      repo = "vim-qf";
      rev = "208d1cdafb3fdbdb91ac5a2aaadd1f0e68f619ba";
      sha256 = "1pr2v4jlf8nsf7l3w0zi4c4nfdynbx2i8jsykgknrjfbp729b1cy";
    };
  };
  vimcompletesme = pkgs.vimUtils.buildVimPlugin {
    name = "vimcompletesme";
    src = pkgs.fetchFromGitHub {
      owner = "ajh17";
      repo = "VimCompletesMe";
      rev = "15156a8939d7eae0bfb2b80ff06999aecb48c124";
      sha256 = "0bzg7gj74nhwcb2ahp1wz60dgh1z7iq54lj16hr9pkbl61w50lbq";
    };
  };
  clean-path-vim = pkgs.vimUtils.buildVimPlugin {
    name = "clean-path-vim";
    src = pkgs.fetchFromGitHub {
      owner = "Guergeiro";
      repo = "clean-path.vim";
      rev = "e501de986f2f089e96014edbfdbea8340e47f97f";
      sha256 = "1ab5174ri98w9h0yyhns1szldk6r5nahmpnn6qzp9r5bji8h77zq";
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
        clean-path-vim
        direnv-vim
        goyo
        vim-commentary
        vim-dispatch
        vim-eunuch
        vim-godot
        vim-obsession
        vim-polyglot
        vim-qf
        vim-qlist
        vim-surround
        vim-unimpaired
        vimcompletesme
      ];
    })
  ];
}
