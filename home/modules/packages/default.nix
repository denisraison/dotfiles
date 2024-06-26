{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.packages;
in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bat
      gnumake
      eza
      docker_24
      gh
      htop
      ipfetch
      keychain
      python39
      nixfmt-classic
      kubectl
      k3d
      k9s
      rustup
      gccgo13
      argocd
      (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.bq])
      fermyon-spin
      go
      gopls
      nodejs_20
      sqld
      lshw
      nodePackages_latest.wrangler
      obsidian
      cloudflared
    ];
  };
}
