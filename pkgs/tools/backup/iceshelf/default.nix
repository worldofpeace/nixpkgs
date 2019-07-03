{ stdenv, lib, fetchFromGitHub, pythonPackages, git, awscli }:

pythonPackages.buildPythonApplication rec {
  pname = "iceshelf";
  version = "unstable-2019-06-18";

  format = "other";

	src = fetchFromGitHub {
		owner = "mrworf";
		repo = pname;
		rev = "26768dde3fc54fa412e523eb8f8552e866b4853b";
		sha256 = "08rcbd14vn7312rmk2hyvdzvhibri31c4r5lzdrwb1n1y9q761qm";
  };

  propagatedBuildInputs = [ git awscli ] ++ (with pythonPackages; [ python-gnupg ]);

	installPhase = ''
		mkdir -p $out/bin $out/share/doc/${pname}
    cp iceshelf iceshelf-restore $out/bin
    cp iceshelf.sample.conf $out/share/doc/${pname}/
	'';

  meta = with lib; {
    description = "A simple tool to allow storage of signed, encrypted, incremental backups using Amazon's Glacier storage";
    license = licenses.lgpl2;
    homepage = "https://github.com/mrworf/iceshelf";
    maintainers = with maintainers; [ mmahut ];
  };


}
