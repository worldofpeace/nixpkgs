{ mkElementary, meson, ninja, pkgconfig, vala, gtk3 }:

mkElementary rec {
  pname = "print";
  version = "0.1.3";

  name = "elementary-print-shim-${version}";

  sha256 = "1w3cfap7j42x14mqpfqdm46hk5xc0v5kv8r6wxcnknr3sfxi8qlp";

  nativeBuildInputs = [
    meson
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [ gtk3 ];

  meta = {
    description = "Simple shim for printing support via Contractor.";
  };
}