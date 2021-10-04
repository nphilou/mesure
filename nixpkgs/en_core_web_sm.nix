{ stdenv,
fetchFromGitHub,
buildPythonPackage
}:

buildPythonPackage rec {
  pname = "en_core_web_sm";
  version = "3.1.1";

  src = fetchFromGitHub {
    owner = "explosion";
    repo = "spacy-models";
    rev = "2058589ec22b2d26ea536ba778137d20c36a4d8f";
    sha256 = "1wiczwsrkc8yzq53f07hq43qxdp8nc83jpbjap15y6vyvsvnawf3";
  };
}