{ lib, config, pkgs, ... }:
with lib;
let cfg = config.modules.nvim;
in {
  options.modules.nvim = { enable = mkEnableOption "nvim"; };
  config = mkIf cfg.enable {
    programs.zsh = {
      initExtra = ''
        export EDITOR="nvim"
      '';

      shellAliases = {
        v = "nvim -i NONE";
        nvim = "nvim -i NONE";
      };
    };

    programs.neovim = { enable = true; };
  };
}