{ stdenv, makeWrapper, symlinkJoin, switchboard, switchboardPlugs, plugs }:

let
  selectedPlugs = if plugs == null then switchboardPlugs else plugs;
in
symlinkJoin {
  name = "switchboard-with-plugs-${switchboard.version}";

  paths = [ switchboard ] ++ selectedPlugs;

  buildInputs = [ makeWrapper ];

  postBuild = ''
    wrapProgram $out/bin/io.elementary.switchboard \
      --set SWITCHBOARD_PLUGS_PATH "$out/lib/switchboard"
  '';

}