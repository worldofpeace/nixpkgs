{ stdenv, makeWrapper, symlinkJoin, wingpanel, wingpanelIndicators, switchboard-with-plugs, indicators ? null }:

let
  selectedIndicators = if indicators == null then wingpanelIndicators else indicators;
in
symlinkJoin {
  name = "wingpanel-with-indicators-${wingpanel.version}";

  paths = [ wingpanel ] ++ selectedIndicators;

  buildInputs = [ makeWrapper ];

  postBuild = ''
    wrapProgram $out/bin/wingpanel \
      --set WINGPANEL_INDICATORS_PATH "$out/lib/wingpanel" \
      --set SWITCHBOARD_PLUGS_PATH "${switchboard-with-plugs}/lib/switchboard" # wingpanel-applications-menu has a plugin to search switchboard settings
  '';

}
