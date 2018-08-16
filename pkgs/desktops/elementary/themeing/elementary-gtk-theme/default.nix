{ mkElementary, meson, ninja }:

mkElementary rec {
  pname = "stylesheet";
  version = "24e5a70adfefc293e7bd19a33090f05a03cc05fe";

  name = "elementary-gtk-theme-2018-08-15";

  sha256 = "0hdm4h2pd7gjps9g9yhjzgv7slcfdnrgprs0s2ww0l2sl9x8pbym";

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = {
    description = "GTK theme designed to be smooth, attractive, fast, and usable";
  };
}
