{ pkgs, ... }: {
  home.username = "zac";
  home.homeDirectory = "/home/zac";
  programs.home-manager.enable = true;
  home.packages = with pkgs; [ mako wl-clipboard kickoff shotman xdg-utils ];
  programs.alacritty = {
    enable = true;
    settings = { window = { opacity = 0.6; }; };
  };

  programs.git = {
  	enable = true;
  	userName = "tapszac";
  	userEmail = "zhrris@gmail.com";
  };
  
  programs.waybar = {
  	 enable = true;
  	 style = ./waybar-style.css;
  	 settings = {
  	 mainBar = {
  	 	layer = "top";
  	 	modules-left = [ "sway/workspaces" "sway/mode" ];
  	 	modules-center = [ "sway/window" ];
  	 	modules-right = [ "pulseaudio" "network" "battery" "clock" ];

		"network" = {
		#	format = "{ifname}";
    	#	format-wifi = "{essid} ({signalStrength}%) "; this includes the network name
    		format-wifi = "({signalStrength}%) ";	#this does not include network name
		};

		"clock" = {
			format = "{:%b %d %I:%M %p}";
		};
  	 	"sway/window" = {
  	 		format = "{app_id}";
  	 		max-length  = 50;
  	 	 };
  	 	"pulseaudio" = {
  	 	 	max-volume = 200;
  	 	 	format = "{volume}% {icon}";
    		format-muted = "";
    		format-icons = {
        		default = ["" ""];
		 };
		 };
  	 	"battery" = {
  	 		states = {
  	 			good = 90;
  	 			warning = 30;
  	 			critical = 15;
  	 		};
  	 		format = "{capacity}% {icon}";
		    format-icons = ["" "" "" "" ""];
  	 		};  	 	 
  	 };
		 	 
  };

  };


   
  services.mako = {
    enable = true;
    defaultTimeout = 3000;
  };
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4"; # super key
      terminal = "alacritty";
      menu = "kickoff";
      defaultWorkspace = "workspace number 1";
      bars = [{ command = "waybar"; }];
      gaps = { inner = 5; };
      startup = [
      	 {command = "firefox";}
      	 {command = "telegram-desktop";}
      	 ];

      assigns = {
      	"2" = [{ app_id = "org.telegram.desktop"; }];
      };	 

	  colors = {
	  	urgent = {
	  		background = "#daf7a6";
	  		border = "#2f343a";
	  		childBorder = "#daf7a6";
	  		indicator = "#daf7a6";
	  		text = "#ffffff";
	  	};
	  };
	  
#	  this completely binds kb shortcuts, however it clears all defaults so be careful 
#      keybindings = {
#      	"Mod4+b" = "exec firefox";
#      };

       input = {
        "*" = { accel_profile = "flat"; };

        "type:touchpad" = {
          click_method = "clickfinger";
          middle_emulation = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          pointer_accel = "1";
        };
        "type:keyboard" = {
        #Remap caps lock to backspace
        #Remap menu key to Mod4MYR
        	xkb_options = "caps:backspace,altwin:alt_super_win";
        	xkb_numlock = "enabled";
        	 
        };
      }; 
            
      window.titlebar = false;
    };
    extraConfig = ''
      bindsym Mod4+Shift+s         exec shotman -c region
      bindsym XF86MonBrightnessDown exec brightnessctl set 5%-
      bindsym XF86MonBrightnessUp exec brightnessctl set +5%
      bindsym XF86AudioRaiseVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ +5%'
      bindsym XF86AudioLowerVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ -5%'
      bindsym XF86AudioMute exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'
      bindsym XF86AudioPlay exec playerctl play-pause
      bindsym XF86AudioNext exec playerctl next
      bindsym XF86AudioPrev exec playerctl previous



      bindgesture swipe:4:right workspace prev
      bindgesture swipe:4:left workspace next
'';
  };
  home.stateVersion = "23.11";
}
