{ stdenv
, fetchFromGitHub
, buildPythonPackage
, ipython
}:

buildPythonPackage rec {
  pname = "watermark";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "rasbt";
    repo = pname;
    rev = "d3553b68dd30ac5b0951a6fae6083236e4c7f3bd";
    sha256 = "0w2mzi344x1mrv8d9jca67bhig34jissr9sqrk68gpg5n10alblb";
  };
  dontUseSetuptoolsCheck = true;
  propagatedBuildInputs = [
    ipython
  ];
}