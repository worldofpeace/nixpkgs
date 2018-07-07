{ stdenv, fetchgit, fetchpatch, pkgconfig, meson, ninja, vala, python3, gtk-doc, docbook_xsl, docbook_xml_dtd_43, docbook_xml_dtd_412, glib, check, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "libsignon-glib";
  version = "2.0";

  name = "${pname}-${version}";

  outputs = [ "out" "dev" "devdoc" "py" ];

  src = fetchgit {
    url = "https://gitlab.com/accounts-sso/${pname}";
    rev = "refs/tags/VERSION_${version}";
    fetchSubmodules = true;
    sha256 = "11156bklr43j8xbx90sjw8pgl5vpj9vc2qz0c4bvh79zs23b9xnl";
  };

  nativeBuildInputs = [
    check
    docbook_xml_dtd_412
    docbook_xml_dtd_43
    docbook_xsl
    gobjectIntrospection
    gtk-doc
    meson
    ninja
    pkgconfig
    python3
    vala
  ];

  buildInputs = [
    glib
    python3.pkgs.pygobject3
  ];

  patches = [
    # See -> https://gitlab.com/accounts-sso/libsignon-glib/merge_requests/20
    (fetchpatch {
      url = "https://gitlab.com/jtojnar/libsignon-glib/commit/deb73f9844b8f43e2e1b315e8495b6db752b3c4e.patch";
      sha256 = "1qv0rnmkcli8gz0nh9y4rircqlap730a94w17b8b555nz0z38iyh";
    })
    # Add option to specify path to pygobject override directory
    ./override-dir.patch
    # Fixes build with meson 0.48.0 - See -> https://gitlab.com/accounts-sso/libsignon-glib/merge_requests/18
    # (fetchpatch {
    #   url = "https://gitlab.com/worldofpeace/libsignon-glib/commit/2051cdd78d2a6936f4c1f49ead1f87d764d32a26.patch";
    #   sha256 = "0rwfd39i0j8s4ng3ix2h6pci2znq1gxxis0js3rpcx3n9ckv3089";
    # })
  ];

  mesonFlags = [
    "-Dintrospection=true"
    "-Dpygi-overrides-dir=${placeholder "py"}/${python3.sitePackages}/gi/overrides"
  ];

  postPatch = ''
    chmod +x build-aux/gen-error-map.py
    patchShebangs build-aux/gen-error-map.py
  '';

  meta = with stdenv.lib; {
    description = ''
      A library for managing single signon credentials which can be used from GLib applications
    '';
    homepage = https://gitlab.com/accounts-sso/libsignon-glib;
    license = licenses.lgpl21;
    maintainers = with maintainers; [ worldofpeace ];
    platforms = platforms.linux;
  };
}

