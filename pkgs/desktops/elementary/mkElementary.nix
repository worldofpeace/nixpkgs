{ stdenv, fetchgit }:

{ pname, sha256 ? null, version, ... } @ args:

let
  inherit (builtins) filter getAttr head isList;
  inherit (stdenv.lib) attrNames concatLists recursiveUpdate zipAttrsWithNames;

  filterAttrNames = f: attrs:
    filter (n: f (getAttr n attrs)) (attrNames attrs);

  concatAttrLists = attrsets:
    zipAttrsWithNames (filterAttrNames isList (head attrsets)) (_: concatLists) attrsets;

  template = rec {
    src = fetchgit {
      url = "https://github.com/elementary/${pname}";
      rev = version;
      inherit sha256;
    };

    meta = with stdenv.lib; {
      homepage = "https://github.com/elementary/${pname}";
      license = licenses.lgpl3;
      platforms = platforms.linux;
      maintainers = with maintainers; [ worldofpeace ];
    };
  };

  publicArgs = removeAttrs args [ "pname" "sha256" ];
in

stdenv.mkDerivation (recursiveUpdate template publicArgs // concatAttrLists [ template args ])
