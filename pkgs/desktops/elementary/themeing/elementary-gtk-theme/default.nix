{ mkElementary, meson, ninja }:

mkElementary rec {
  pname = "stylesheet";
  version = "b350fa09b6c4455e8cda012bd8a76127a96baf89";

  name = "elementary-gtk-theme-2018-09-08";

  sha256 = "0nkyaka2lmaj5mzqvvcsghr4nmilarwdvclc341ypsghy4i47pbh";

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = {
    description = "GTK theme designed to be smooth, attractive, fast, and usable";
  };
}
