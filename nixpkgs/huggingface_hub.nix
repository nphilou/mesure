{ stdenv
, fetchFromGitHub
, buildPythonPackage
, requests
, typing-extensions
, packaging
, pyyaml
, filelock
, tqdm
}:

buildPythonPackage rec {
  pname = "huggingface-hub";
  version = "0.0.19";

  src = fetchFromGitHub {
    owner = "huggingface";
    repo = "huggingface_hub";
    rev = "c7373dec8774d4066071a9ad217939b06c90f75c";
    sha256 = "1l8fd5rlb2lr4al9a4v9sf4lppfkgfqpxiklxh4sl1hjha1247lm";
  };

  doCheck = false;

  propagatedBuildInputs = [
    typing-extensions
    requests
    packaging
    pyyaml
    filelock
    tqdm
  ];
}