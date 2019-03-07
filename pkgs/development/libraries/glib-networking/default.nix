{ stdenv, fetchurl, meson, ninja, pkgconfig, glib, gettext, python3, gnutls, p11-kit, libproxy, gnome3
, gsettings-desktop-schemas }:

let
  pname = "glib-networking";
  version = "2.59.91";
in
stdenv.mkDerivation rec {
  name = "${pname}-${version}";

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${stdenv.lib.versions.majorMinor version}/${name}.tar.xz";
    sha256 = "15w2alls8v332w912yk6h4qpl1a03j21hw4cz2vssxxyp50s12cp";
  };

  outputs = [ "out" "dev" ]; # to deal with propagatedBuildInputs

  PKG_CONFIG_GIO_2_0_GIOMODULEDIR = "${placeholder "out"}/lib/gio/modules";

  postPatch = ''
    chmod +x meson_post_install.py # patchShebangs requires executable file
    patchShebangs meson_post_install.py
  '';

  nativeBuildInputs = [
    meson ninja pkgconfig gettext
    python3 # install_script
  ];
  propagatedBuildInputs = [ glib gnutls p11-kit libproxy gsettings-desktop-schemas ];

  mesonFlags = [
    # Default auto detection doesn't work
    "-Dgnutls=enabled"
  ];

  doCheck = false; # tests need to access the certificates (among other things)

  passthru = {
    updateScript = gnome3.updateScript {
      packageName = pname;
    };
  };

  meta = with stdenv.lib; {
    description = "Network-related giomodules for glib";
    license = licenses.lgpl2Plus;
    platforms = platforms.unix;
  };
}
