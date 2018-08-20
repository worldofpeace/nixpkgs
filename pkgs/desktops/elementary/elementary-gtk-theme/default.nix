{ mkElementary }:

mkElementary rec {
  pname = "stylesheet";
  version = "5.1.1";

  name = "elementary-gtk-theme-${version}";

  sha256 = "1749byc2lbxmprladn9n7k6jh79r8ffgayjn689gmqsrm6czsmh2";

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/themes/elementary
    cp -r gtk-* plank $out/share/themes/elementary
  '';

  meta = {
    description = "GTK theme designed to be smooth, attractive, fast, and usable";
  };
}
