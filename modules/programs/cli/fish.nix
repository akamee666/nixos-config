{ lib, pkgs, ...}: {
	programs.fish = {
		enable = true;
		shellAliases = {
      # General
			rl="readlink -f";
			r="y";
			ranger="y";
			n="nvim";
			nv="nvim .";
			cls="clear ; cd";
			logoff="killall -u $USER";
			rm="rm -I";
			rf="rm -rf -I";
			b64="base64";
			bd="base64 -d";
			md="mkdir";
			chx="chmod +x";
			rmexif="exiftool -all=";
			cfg="cd /etc/nixos/";
			diff="difft";
			htop="btop";
			find="fd --color never";

			# git
			gcl="git clone";
			gst="git status";
      lola="git log --graph --pretty=\"format:%C(auto)%h %d %s %C(green)(%ad) %C(cyan) <%an >\" --abbrev-commit --all --date=relative";
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
