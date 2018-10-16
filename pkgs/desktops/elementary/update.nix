{ lib, writeScript, runCommand, nix, perl, git, jq, nix-prefetch-scripts, coreutils, common-updater-scripts, gnugrep, gnused }:
{ repoName, attrPath ? repoName }:
let
  script = ./update.sh;

  updateScript = runCommand "update.sh" {} ''
    cp ${script} update.sh
    patchShebangs update.sh
    mv update.sh $out
  '';
in
writeScript "update-${repoName}" ''
  PATH=${lib.makeBinPath [ perl git jq nix nix-prefetch-scripts coreutils common-updater-scripts gnugrep gnused ]}
  ${updateScript} -r "${repoName}" "${attrPath}"
''

