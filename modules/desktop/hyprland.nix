{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprwinwrap
    ];
    systemd = {
      enable = true;
      variables = ["--all"];
    };

    settings = {
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "GDK_BACKEND,wayland,x11,*"
        "NIXOS_OZONE_WL,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "MOZ_ENABLE_WAYLAND,1"
        "OZONE_PLATFORM,wayland"
        "EGL_PLATFORM,wayland"
        "CLUTTER_BACKEND,wayland"
        "SDL_VIDEODRIVER,wayland"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "NIXPKGS_ALLOW_UNFREE,1"
      ];

      "$mainMod" = "SUPER";
      "$term" = "alacritty";
      "$editor" = "nvim";
      "$fileManager" = "$term --class \"terminalFileManager\" -e yazi";
      "$browser" = "brave";

      exec-once = [
        #"[workspace 1 silent] ${terminal}"
        #"[workspace 5 silent] ${browser}"
        #"[workspace 6 silent] spotify"
        #"[workspace special silent] ${browser} --private-window"
        #"[workspace special silent] ${terminal}"

        # "waybar"
        # "swaync"
        # "nm-applet --indicator"
        # "wl-clipboard-history -t"
        # "${getExe' pkgs.wl-clipboard "wl-paste"} --type text --watch cliphist store" # clipboard store text data
        # "${getExe' pkgs.wl-clipboard "wl-paste"} --type image --watch cliphist store" # clipboard store image data
        # "rm '$XDG_CACHE_HOME/cliphist/db'" # Clear clipboard
        # "${./scripts/batterynotify.sh}" # battery notification
        # # "${./scripts/autowaybar.sh}" # uncomment packages at the top
        # "polkit-agent-helper-1"
        # "pamixer --set-volume 50"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_options = caps:swapescape;

        follow_mouse = 1;

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        # force_no_accel = true;
      };
      general = {
        gaps_in = 4;
        gaps_out = 9;
        border_size = 2;
        "col.active_border" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.inactive_border" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
        resize_on_border = true;
        layout = "dwindle"; # dwindle or master
        # allow_tearing = true; # Allow tearing for games (use immediate window rules for specific games or all titles)
      };

      decoration = {
        shadow.enabled = false;
        rounding = 10;
        dim_special = 0.3;
      };

      group = {
        "col.border_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.border_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
        "col.border_locked_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.border_locked_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
      };

      layerrule = [
        "ignorezero, rofi"
        "ignorealpha 0.7, rofi"
        "ignorezero, swaync-control-center"
        "ignorezero, swaync-notification-window"
        "ignorealpha 0.7, swaync-control-center"
      ];

      # FIXME: Should i keep it?
      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "fluent_decel, 0.1, 1, 0, 1"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];

        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 2.5, md3_decel"
          "workspaces, 1, 3.5, easeOutExpo, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      misc = {
        disable_hyprland_logo = true;
        mouse_move_focuses_monitor = true;
        swallow_regex = "^(Alacritty|kitty)$";
        enable_swallow = true;
        vfr = true; # always keep on
        vrr = 1; # enable variable refresh rate (0=off, 1=on, 2=fullscreen only)
      };

      xwayland.force_zero_scaling = false;

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
        new_on_top = true;
        mfact = 0.5;
      };

      windowrule = [
        # Move applications to different workspaces
        #"noanim, class:^(Rofi)$
        # "tile,title:(.*)(Godot)(.*)$"
        # "workspace 1, class:^(kitty|Alacritty|org.wezfurlong.wezterm)$"
        # "workspace 2, class:^(code|VSCodium|code-url-handler|codium-url-handler)$"
        # "workspace 3, class:^(krita)$"
        # "workspace 3, title:(.*)(Godot)(.*)$"
        # "workspace 3, title:(GNU Image Manipulation Program)(.*)$"
        # "workspace 3, class:^(factorio)$"
        # "workspace 3, class:^(steam)$"
        # "workspace 5, class:^(firefox|floorp|zen)$"
        # "workspace 6, class:^(Spotify)$"
        # "workspace 6, title:(.*)(Spotify)(.*)$"

        "float,class:^(qt5ct)$"
        "float,class:^(nwg-look)$"
        "float,class:^(org.kde.ark)$"
        "float,class:^(Signal)$" #Signal-Gtk
        "float,class:^(com.github.rafostar.Clapper)$" #Clapper-Gtk
        "float,class:^(app.drey.Warp)$" #Warp-Gtk
        "float,class:^(net.davidotek.pupgui2)$" #ProtonUp-Qt
        "float,class:^(eog)$" #Imageviewer-Gtk
        "float,class:^(io.gitlab.theevilskeleton.Upscaler)$" #Upscaler-Gtk
        "float,class:^(yad)$"
        "float,class:^(pavucontrol)$"
        "float,class:^(blueman-manager)$"
        "float,class:^(.blueman-manager-wrapped)$"
        "float,class:^(nm-applet)$"
        "float,class:^(nm-connection-editor)$"
        "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
      ];

      binde = [
        # Functional keybinds
        ",XF86MonBrightnessDown,exec,brightnessctl set 2%-"
        ",XF86MonBrightnessUp,exec,brightnessctl set +2%"
        ",XF86AudioLowerVolume,exec,pamixer -d 2"
        ",XF86AudioRaiseVolume,exec,pamixer -i 2"
      ];

      bind =
        [
          # Keybinds help menu
          # FIXME: add scripts
          # "$mainMod, question, exec, ${./scripts/keybinds.sh}"

          # Night Mode (lower value means warmer temp)
          # FIXME: might be useful
          # "$mainMod, F9, exec, ${getExe pkgs.hyprsunset} --temperature 3500" # good values: 3500, 3000, 2500
          # "$mainMod, F10, exec, pkill hyprsunset"

          # Window/Session actions
          "$mainMod, Q, killactive" # killactive, kill the window on focus
          "$mainMod, delete, exit" # kill hyperland session
          "$mainMod, SPACE, togglefloating" # toggle the window on focus to float
          "$mainMod SHIFT, G, togglegroup" # toggle the window on focus to float
          "$mainMod, F, fullscreen" # toggle the window on focus to fullscreen

          # Applications/Programs
          "$mainMod, Return, exec, $term"
          "$mainMod SHIFT, Return, exec, [float;] $term"
          "$mainMod, E, exec, $fileManager"
          "$mainMod SHIFT, F, exec, $browser"
          "$mainMod SHIFT, S, exec, spotify"

          # FIXME: I do not have rofi yet
          # "$mainMod, D, exec, pkill -x rofi || ${./scripts/rofi.sh} drun" # launch desktop applications

          # Functional keybinds
          ",xf86Sleep, exec, systemctl suspend" # Put computer into sleep mode
          ",XF86AudioMicMute,exec,pamixer --default-source -t" # mute mic
          ",XF86AudioMute,exec,pamixer -t" # mute audio
          ",XF86AudioPlay,exec,playerctl play-pause" # Play/Pause media
          ",XF86AudioPause,exec,playerctl play-pause" # Play/Pause media
          ",xf86AudioNext,exec,playerctl next" # go to next media
          ",xf86AudioPrev,exec,playerctl previous" # go to previous media

          # Screenshoot
          "$mainMod, S, exec, ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy --type image/png"

          # to switch between windows in a floating workspace
          "ALT, Tab, cyclenext"
          "ALT, Tab, bringactivetotop"

          # move to the first empty workspace instantly with mainMod + CTRL + [↓]
          "$mainMod CTRL, down, workspace, empty"

          # Move focus with mainMod + arrow keys
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Move focus with mainMod + HJKL keys
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ]
        ++ (builtins.concatLists (builtins.genList (x: let
            ws = let
              c = (x + 1) / 10;
            in
              builtins.toString (x + 1 - (c * 10));
          in [
            # Go to workspace
            "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
            # Move window and go to workspace
            "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            # Only move window
            "$mainMod CTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
          ])
          10));

      bindm = [
        # Move/Resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };

    extraConfig = ''
      binds {
        workspace_back_and_forth = 1
        #allow_workspace_cycles=1
        #pass_mouse_when_bound=0
      }

      # Easily plug in any monitor
      monitor=,preferred,auto,1
    '';
  };
}
