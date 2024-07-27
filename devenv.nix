{ pkgs, config, inputs, ... }: {
  cachix.enable = false;
  dotenv.disableHint = true;

  languages.javascript = {
    enable = true;
    package = pkgs.nodejs_20;
  };
}
