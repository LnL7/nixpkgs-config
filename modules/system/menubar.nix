{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.system.menubar;

  items = {
    Airport         = "/System/Library/CoreServices/Menu Extras/AirPort.menu";
    Battery         = "/System/Library/CoreServices/Menu Extras/Battery.menu";
    Bluetooth       = "/System/Library/CoreServices/Menu Extras/Bluetooth.menu";
    Clock           = "/System/Library/CoreServices/Menu Extras/Clock.menu";
    Displays        = "/System/Library/CoreServices/Menu Extras/Displays.menu";
    Eject           = "/System/Library/CoreServices/Menu Extras/Eject.menu";
    Fax             = "/System/Library/CoreServices/Menu Extras/Fax.menu";
    HomeSync        = "/System/Library/CoreServices/Menu Extras/HomeSync.menu";
    Ink             = "/System/Library/CoreServices/Menu Extras/Ink.menu";
    IrDA            = "/System/Library/CoreServices/Menu Extras/IrDA.menu";
    Keychain        = "/Applications/Utilities/Keychain Access.app/Contents/Resources/Keychain.menu";
    PPP             = "/System/Library/CoreServices/Menu Extras/PPP.menu";
    PPPoE           = "/System/Library/CoreServices/Menu Extras/PPPoE.menu";
    RemoteDesktop   = "/System/Library/CoreServices/Menu Extras/RemoteDesktop.menu";
    ScriptMenup     = "/System/Library/CoreServices/Menu Extras/Script Menu.menu";
    TextInput       = "/System/Library/CoreServices/Menu Extras/TextInput.menu";
    TimeMachine     = "/System/Library/CoreServices/Menu Extras/TimeMachine.menu";
    UniversalAccess = "/System/Library/CoreServices/Menu Extras/UniversalAccess.menu";
    User            = "/System/Library/CoreServices/Menu Extras/User.menu";
    VPN             = "/System/Library/CoreServices/Menu Extras/VPN.menu";
    Volume          = "/System/Library/CoreServices/Menu Extras/Volume.menu";
    WWAN            = "/System/Library/CoreServices/Menu Extras/WWAN.menu";
    iChat           = "/System/Library/CoreServices/Menu Extras/iChat.menu";
  };

in {
  options = {
    system.menubar.items = mkOption {
      type = types.nullOr (types.listOf (types.enum (attrNames items)));
      default = null;
      description = "Items to display in the menubar";
    };
  };

  config = {

    system.activationScripts.menubar.text = optionalString (!isNull cfg.items) ''
      defaults write com.apple.systemuiserver menuExtras -array ${builtins.toString (map (k: "'" + (builtins.getAttr k items) + "'") cfg.items)}

      killall SystemUIServer
    '';

  };
}
