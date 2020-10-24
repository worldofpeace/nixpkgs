{ stdenv
, fetchFromGitHub
, buildGoPackage
}:

buildGoPackage rec {
  pname = "goofys";
  version = "0.24.0";

  goPackagePath = "github.com/kahing/goofys";

  src = fetchFromGitHub {
    owner = "kahing";
    repo = pname;
    rev = "v${version}";
    sha256 = "ooNCDqfRv6GCiZvWe79Zk+oR50HhhQJioI6ez61eeDw=";
    fetchSubmodules = true;
  };

  buildFlagsArray = [
    "-ldflags=-X main.Version=${version}"
  ];

  postInstall = ''
    ln -s $out/bin/goofys $out/bin/mount.goofys
  '';

  meta = with stdenv.lib; {
    description = "High-performance, POSIX-ish Amazon S3 file system written in Go";
    homepage = "https://github.com/kahing/goofys";
    license = licenses.asl20;
    maintainers = with maintainers; [ worldofpeace ];
    platforms = platforms.linux;
  };
}
