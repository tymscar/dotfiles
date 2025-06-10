{ ... }:
{
  xdg.configFile = {
    "karabiner/assets/complex_modifications/mx_master.json".text = builtins.toJSON {
      title = "MX Master Custom - Nix managed";
      rules = [
        {
          description = "Remap MX Master Back/Forward to Command + / -";
          manipulators = [
            {
              type = "basic";
              from = {
                pointing_button = "button4"; # Back Button
              };
              to = [
                {
                  key_code = "hyphen";
                  modifiers = [ "command" ];
                }
              ];
              conditions = [
                {
                  type = "device_if";
                  identifiers = [
                    {
                      vendor_id = 1133; # Logitech
                      product_id = 50475; # My mouse
                      is_keyboard = false;
                      is_pointing_device = true;
                    }
                  ];
                }
              ];
            }
            {
              type = "basic";
              from = {
                pointing_button = "button5"; # Forward Button
              };
              to = [
                {
                  key_code = "equal_sign";
                  modifiers = [ "command" ];
                }
              ];
              conditions = [
                {
                  type = "device_if";
                  identifiers = [
                    {
                      vendor_id = 1133; # Logitech
                      product_id = 50475; # My mouse
                      is_keyboard = false;
                      is_pointing_device = true;
                    }
                  ];
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
