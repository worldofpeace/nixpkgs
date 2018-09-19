{ fetchurl, substituteAll, stdenv, meson, ninja, pkgconfig, gnome3, perl, gettext, glib
, libnotify, lcms2, libXtst, libxkbfile, libpulseaudio, alsaLib, libcanberra-gtk3, upower
, colord, polkit, geoclue2, librsvg, xf86_input_wacom, udev, libgudev, libwacom, libxslt
, libxml2, networkmanager, docbook_xsl, wrapGAppsHook, ibus, xkeyboard_config, tzdata, nss
, accountsservice, python3 }:

stdenv.mkDerivation rec {
  name = "elementary-settings-daemon-${version}";
  version = "3.28.1";

  src = fetchurl {
    url = "mirror://gnome/sources/gnome-settings-daemon/3.28/gnome-settings-daemon-${version}.tar.xz";
    sha256 = "0z9dip9p0iav646cmxisii5sbkdr9hmaklc5fzvschpbjkhphksr";
  };

  patches = [
    (substituteAll {
      src = ./fix-paths.patch;
      inherit tzdata;
    })
    (fetchurl {
      url = "https://github.com/elementary/os-patches/raw/b38514afce8316dbddd8393b118708386d2f6819/debian/patches/45_suppress-printer-may-not-be-connected-notification.patch";
      sha256 = "0clpcki8cvb2y325s1ll7crhxvwan8627psa9wlfli75dpc5kfw2";
    })
    # Build fails - See -> https://gist.github.com/worldofpeace/9fd59c4018d3973afbe9bf5ce4c82a4c
    # (fetchurl {
    #   url = "https://github.com/elementary/os-patches/raw/b38514afce8316dbddd8393b118708386d2f6819/debian/patches/53_sync_input_sources_to_accountsservice.patch";
    #   sha256 = "0mcjw7cxyhhvmx14sgjcl5ckkdzkazp3a0xkbygxq0clq72n1i8h";
    # })
    (fetchurl {
      url = "https://github.com/elementary/os-patches/raw/b38514afce8316dbddd8393b118708386d2f6819/debian/patches/64_restore_terminal_keyboard_shortcut_schema.patch";
      sha256 = "12z3p5idmdxaaax4dx2aic2iif8z95w5sa6wk217380p9sbi5dzn";
    })
    (fetchurl {
      url = "https://github.com/elementary/os-patches/raw/b38514afce8316dbddd8393b118708386d2f6819/debian/patches/70_allow_sound_above_100.patch";
      sha256 = "0xx35j7pi7jqi9h9j0z2gw9w82327nni0zvihpwd0mbzbqif103c";
    })
    (fetchurl {
      url = "https://github.com/elementary/os-patches/raw/b38514afce8316dbddd8393b118708386d2f6819/debian/patches/correct_logout_action.patch";
      sha256 = "09n6s7lzh0vkpql58agbyg4x5pdgyzh875cgifzpzk2a7424fccv";
    })
    (fetchurl {
      url = "https://github.com/elementary/os-patches/raw/b38514afce8316dbddd8393b118708386d2f6819/debian/patches/ubuntu-lid-close-suspend.patch";
      sha256 = "0b85fb685j7pril91b2zml7kcx0dgv493z1wb3gdblcpmgdzvada";
    })
    (fetchurl {
      url = "https://github.com/elementary/os-patches/raw/b38514afce8316dbddd8393b118708386d2f6819/debian/patches/revert-wacom-migration.patch";
      sha256 = "1bsdqlapcdzn5m8di42prismj1xf57rqb4jw4r0ak0a95vsaas45";
    })
    (fetchurl {
      url = "https://github.com/elementary/os-patches/raw/b38514afce8316dbddd8393b118708386d2f6819/debian/patches/revert-gsettings-removals.patch";
      sha256 = "0g0082vihblblw97pbg7yr6z87252anhm0pjh561jx2v5z58kfv5";
    })
    (fetchurl {
      url = "https://github.com/elementary/os-patches/raw/b38514afce8316dbddd8393b118708386d2f6819/debian/patches/revert-mediakeys-dbus-interface-drop.patch";
      sha256 = "1srnbir2m9kwbgwjbx7mm52hyicvn63mnp9y33bv1mnirh4hqvhs";
    })
    (fetchurl {
      url = "https://github.com/elementary/os-patches/raw/b38514afce8316dbddd8393b118708386d2f6819/debian/patches/ubuntu_ibus_configs.patch";
      sha256 = "1njypm28w0wbhjr09izzpa8wwwalqy4w24s5pva8nadlc9bq7c8p";
    })
    (fetchurl {
      url = "https://github.com/elementary/os-patches/raw/6975d1c254cb6ab913b8e2396877203aea8eaa65/debian/patches/elementary-dpms.patch";
      sha256 = "0kh508ppiv4nvkg30gmw85cljlfq1bvkzhvf1iaxw0snb0mwgsxi";
    })
  ];

  # fatal error: gio/gunixfdlist.h: No such file or directory
  NIX_CFLAGS_COMPILE = "-I${glib.dev}/include/gio-unix-2.0";

  nativeBuildInputs = [
    docbook_xsl
    gettext
    libxml2
    libxslt
    meson
    ninja
    perl
    pkgconfig
    python3
    wrapGAppsHook
  ];

  buildInputs = with gnome3; [
    #accountsservice
    alsaLib
    colord
    geoclue2
    geocode-glib
    glib
    gnome-desktop
    gsettings-desktop-schemas
    gtk
    ibus
    lcms2
    libcanberra-gtk3
    libgudev
    libgweather
    libnotify
    libpulseaudio
    librsvg
    libwacom
    libxkbfile
    libXtst
    networkmanager
    nss
    polkit
    udev
    upower
    xf86_input_wacom
    xkeyboard_config
  ];

  mesonFlags = [
    "-Dudev_dir=${placeholder "out"}/lib/udev"
  ];

  postPatch = ''
    for f in gnome-settings-daemon/codegen.py plugins/power/gsd-power-constants-update.pl meson_post_install.py; do
      chmod +x $f
      patchShebangs $f
    done
  '';

  postFixup = ''
    for f in $out/etc/xdg/autostart/*; do mv "$f" "''${f%.desktop}-pantheon.desktop"; done

    for autostart in $(grep -rl "OnlyShowIn=GNOME;" $out/etc/xdg/autostart)
    do
      echo "Patching OnlyShowIn to Pantheon in: $autostart"
      sed -i "s,OnlyShowIn=GNOME;,OnlyShowIn=Pantheon;," $autostart
    done

    rm $out/etc/xdg/autostart/org.gnome.SettingsDaemon.ScreensaverProxy-pantheon.desktop
  '';

  meta = with stdenv.lib; {
    license = licenses.gpl2Plus;
    maintainers = maintainers.worldofpeace;
    platforms = platforms.linux;
  };
}
