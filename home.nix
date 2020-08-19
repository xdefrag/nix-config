{ lib, pkgs, config, ... }:

with builtins;

let
  bash-sensible = fetchurl
    "https://raw.githubusercontent.com/mrzool/bash-sensible/master/sensible.bash";
  dollchan = fetchurl
    "https://raw.githubusercontent.com/SthephanShinkufag/Dollchan-Extension-Tools/master/src/Dollchan_Extension_Tools.es6.user.js";
in {
  accounts.email.maildirBasePath = ".mail";

  accounts.email.accounts = {
    s = {
      address = "s@humanramen.dev";
      userName = "s@humanramen.dev";
      realName = "Stanislav Karkavin";
      primary = true;
      passwordCommand = "${pkgs.pass}/bin/pass s@humanramen.dev";
      msmtp = {
        enable = true;
        extraConfig = { tls_starttls = "on"; };
      };
      notmuch.enable = true;
      neomutt.enable = true;
      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
        remove = "both";
      };
      smtp = {
        host = "mail.humanramen.dev";
        port = 587;
      };
      imap = {
        host = "mail.humanramen.dev";
        port = 993;
      };
    };
  };

  home.sessionVariables = { EDITOR = "vim"; };

  home.keyboard = {
    layout = "us,ru";
    options = [ "grp:ctrl_shift_toggle" "ctrl:swapcaps" ];
  };

  news.display = "silent";

  programs = {
    home-manager.enable = true;
    bash = {
      initExtra = (readFile bash-sensible + ''
        export PS1="\w \[\033[38;5;4m\]⚔️ \[$(tput sgr0)\] "
        export PAGER="w3m"

        cat ~/.cache/wal/sequences

        eval "$(direnv hook bash)"
      '');
      enable = true;
      enableAutojump = true;
      sessionVariables = {
        BROWSER = "qutebrowser";
        EDITOR = "vim";
        VISUAL = "$EDITOR";
        PATH = "$PATH:~/bin";
      };
      shellAliases = {
        v = "vim";
        vv = "cd ~/docs && vim ~/docs/index.md";
        vh = "cd ~/nix-config && vim ~/nix-config/home.nix";
        l = "ls -h --group-directories-first";
        la = "ls -h --group-directories-first --all";
        ".." = "cd ..";
        ns = "sudo nixos-rebuild switch";
        hs = "home-manager switch";
        t = "gotop";
        p = "progress";
      };
    };
    git = {
      enable = true;
      signing.key = "D0395157";
      userEmail = "s@humanramen.dev";
      userName = "Stanislav Karkavin";
      extraConfig = { pull = { rebase = true; }; };
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
    };
    notmuch = {
      enable = true;
      search.excludeTags = [ "deleted" "spam" "trash" "archive" ];
      new.tags = [ "unread" "inbox" ];
      hooks = {
        preNew = "mbsync -a";
        postNew = ''
          notmuch tag -inbox +sent -- from:me@xdefrag.dev or from:mycoldwinter@gmail.com or from:s@humanramen.dev
          notmuch tag +newsletters -inbox -- from:peter@golangweekly.com or from:peter@webopsweekly.com
          notmuch tag +notifications -inbox -- from:'*info*' or from:'*noreply*' or from:'*no-reply*' or from:'*postmaster*'
        '';
      };
    };
    neomutt = {
      enable = true;
      vimKeys = true;
      sort = "date-received";
      macros = [{
        action = "<modify-labels-then-hide>+archive -unread -inbox<enter>";
        key = "A";
        map = "index";
      }];
      extraConfig = ''
        set date_format="%m-%d"
        set index_format="%d | %-30F %s [%g]"

        set help=no

        auto_view text/html
        alternative_order text/plain text/html

        set fast_reply=yes
        set include=yes

        set virtual_spoolfile=yes
        set folder=notmuch-root-folder
        virtual-mailboxes "inbox" "notmuch://?query=tag:inbox"
        virtual-mailboxes "sent" "notmuch://?query=tag:sent"
        virtual-mailboxes "newsletters" "notmuch://?query=tag:newsletters"
        virtual-mailboxes "notifications" "notmuch://?query=tag:notifications"
        virtual-mailboxes "archive" "notmuch://?query=tag:archive"
      '';
    };
    mbsync = { enable = true; };
    msmtp = { enable = true; };
    newsboat = {
      enable = true;
      autoReload = true;
      extraConfig = readFile ./dotfiles/newsboat;
    };
    rtorrent.enable = true;
    ssh.enable = true;
  };

  gtk.enable = false;
  qt.enable = false;

  services = {
    syncthing.enable = true;
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 34560000;
      maxCacheTtl = 34560000;
    };
    mbsync = {
      enable = true;
      frequency = "*:0/5";
      postExec = "${pkgs.notmuch}/bin/notmuch new";
    };
    lorri.enable = true;
  };

  xdg = {
    enable = true;
    configFile = {
      "rtorrent/rtorrent.rc".source = ./dotfiles/rtorrent.rc;
      "qutebrowser/config.py".source = ./dotfiles/qutebrowser.py;
      "qutebrowser/qutewal.py".source = ./dotfiles/qutewal.py;
      "git/ignore".text = ''
        dist/

        tags
        tags.lock
      '';
    };
    mime.enable = false;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/epub+zip" = [ "org.pwmt.zathura.desktop" ];
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "default-web-browser" = [ "org.qutebrowser.qutebrowser.desktop" ];
        "image/jpeg" = [ "imv.desktop" ];
        "image/png" = [ "imv.desktop" ];
        "text/html" = [ "org.qutebrowser.qutebrowser.desktop" ];
        "text/plain" = [ "vim.desktop" ];
        "x-scheme-handler/mailto" = [ "mutt.desktop" ];
      };
    };
    userDirs = {
      enable = true;
      desktop = "$HOME/desk";
      documents = "$HOME/docs";
      download = "$HOME/tmp";
      music = "$HOME/music";
      pictures = "$HOME/pics";
      publicShare = "$HOME/public";
      templates = "$HOME/templates";
      videos = "$HOME/videos";
    };
  };

  home.file = {
    "bin".source = ./bin;
    ".vim/vimrc".source = ./dotfiles/vim/vimrc;
    ".vim/after/ftplugin".source = ./dotfiles/vim/ftplugin;
    ".vim/autoload".source = ./dotfiles/vim/autoload;
    ".vim/colors".source = ./dotfiles/vim/colors;
    ".vim/compiler".source = ./dotfiles/vim/compiler;
    ".vim/plugin".source = ./dotfiles/vim/plugin;
    ".w3m/keymap".source = ./dotfiles/keymap.w3m;
    ".w3m/config".source = ./dotfiles/config.w3m;
    ".mailcap".source = ./dotfiles/mailcap;
    ".newsboat/urls".text = readFile ~/docs/newsboat-urls;
    ".local/share/qutebrowser/greasemonkey/Dollchan_Extension_Tools.es6.user.js".text =
      readFile dollchan;
      ".xinitrc".text = ''
      pywal -R &
      slstatus &

      exec dwm
    '';
  };
}
