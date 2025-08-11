{
  lib,
  pkgs,
  ...
}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      # General
      rl = "readlink -f";
      r = "y";
      ranger = "y";
      n = "nvim";
      nv = "nvim .";
      cls = "clear ; cd";
      logoff = "killall -u $USER";
      rm = "rm -I";
      rf = "rm -rf -I";
      b64 = "base64";
      bd = "base64 -d";
      md = "mkdir";
      chx = "chmod +x";
      rmexif = "exiftool -all=";
      cfg = "cd /etc/nixos/";
      diff = "difft";
      htop = "btop";
      find = "fd --color never";

      # Nix
      # nhhm = "nh home switch /etc/nixos#homeConfigurations.akame@$1.activationPackage";
      nhos = "nh os switch /etc/nixos";

      # Servers and Vm's
      sharedwin = "cd ~/.akame/sharedwin/";
      mountsshfs_homeserver = "sudo sshfs -o allow_other,default_permissions,kernel_cache,cache=yes akame@192.168.1.100:/home/akame/ ~/.akame/server/ -p 2222";
      mountsshfs_backup = "sudo sshfs -o allow_other,default_permissions,kernel_cache,cache=yes akame@192.168.1.100:/home/shared/ ~/.akame/home-backup/ -p 2222";

      # Rust ;
      cargo_build_win = "cargo build --target x86_64-pc-windows-gnu";
      lint = "./lint.sh";
      clippy = "cargo clippy -- -A clippy::all";

      # Git;
      gcl = "git clone";
      gst = "git status";
      checkpoint = "git add . && git commit";
      lola = "git log --graph --pretty=\"format:%C(auto)%h %d %s %C(green)(%ad) %C(cyan) <%an >\" --abbrev-commit --all --date=relative";
      # Better output;
      du = "dust";
      ip = "ip -color=auto";
      dmesg = "dmesg --color=always";
      cat = "bat --plain --decorations never --paging never";
      catp = "bat --paging always";
      df = "duf -hide-fs squashfs";
      free = "free -h";
      # Shells;
      b = "bash";
      f = "fish";
      # Changing keyboard layout;
      setbr = "setxkbmap -layout br";
      setus = "setxkbmap -layout us";
      # Fast edit/read configs;
      efconf = "nvim /etc/nixos/";
      # Grep;
      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      gp = "grep";
      hg = "history | grep $1";
      # Networking tools;
      ifme = "curl ifconfig.me";
      ssp = "ss -tupan | grep $1";
      nethogs = "sudo nethogs";
      iftop = "sudo iftop";
      mm = "mitmproxy";
      # Visual configs;
      panes = "/opt/shell-color-scripts/colorscripts/panes";
      fehbgr = "feh --bg-fill $(shuf -n 1 -e ~/Pictures/wallpapers/dark/*) --bg-fill ~/Pictures/wallpapers/justblack.jpg";
      frenzch = "~/frenzch.sh/frenzch.sh";
      clock = "tty-clock -c -C4";
      # "ls" to "eza";
      sl = "ls";
      ls = "eza --icons --color=always --group-directories-first";
      l = "eza --icons --color=always --group-directories-first";
      la = "eza --icons -laF --octal-permissions --color=always --group-directories-first";
      ll = "eza --icons -lF --octal-permissions --color=always --group-directories-first";
      lsize = "/usr/bin/du -hs * | sort -hr | less";
      # Processes;
      psa = "ps auxf";
      psgrep = "ps aux | grep -v grep | grep -i -e VSZ -e";
      psmem = "ps auxf | sort -nr -k 4";
      pscpu = "ps auxf | sort -nr -k 3";
      # Systemd;
      std = "sudo systemctl start";
      rrd = "sudo systemctl restart";
      stopd = "sudo systemctl stop";
      stts = "systemctl status";
      isfd = "systemctl is-failed";
      # Logging;
      lastjctl = "journalctl -p 3 -xb";
    };

    interactiveShellInit = ''
      # SWAP FISH AUTOSUGGESTION KEYS
      # TAB -> Accept suggestion
      bind \t accept-autosuggestion

      # Ctrl+F -> Show suggestions
      bind \cf complete

      # Remove greeting
      set fish_greeting
    '';

    functions = {
      fish_prompt = {
        body = ''
          # This is a simple prompt. It looks like
          # alfa@nobby /path/to/dir $
          # with the path shortened and colored
          # and a "#" instead of a "$" when run as root.
          set -l symbol ' $ '
          set -l color $fish_color_cwd
          if fish_is_root_user
            set symbol ' # '
              set -q fish_color_cwd_root
              and set color $fish_color_cwd_root
              end

              echo -n $USER@$hostname

              set_color $color
              echo -n (prompt_pwd)
              set_color normal

              echo -n $symbol
        '';
      };

      nhhm = {
          body = ''
            nh home switch /etc/nixos#homeConfigurations.akame@$argv[1].activationPackage
          '';
      };

      y = {
        body = ''
          set tmp (${pkgs.coreutils}/bin/mktemp -t "yazi-cwd.XXXXXX")
          ${lib.getExe pkgs.yazi} $argv --cwd-file="$tmp"
          if set cwd (command ${pkgs.coreutils}/bin/cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
              end
              ${pkgs.coreutils}/bin/rm -f -- "$tmp"
        '';
      };
    };
  };
}
