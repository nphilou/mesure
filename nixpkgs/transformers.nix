{ buildPythonPackage
, lib
, fetchFromGitHub
, callPackage
, pythonOlder
, cookiecutter
, filelock
, importlib-metadata
, regex
, requests
, numpy
, packaging
, protobuf
, pyyaml
, sacremoses
, tokenizers
, tqdm
}:

let
  huggingface-hub = callPackage ./huggingface_hub.nix {};
in
buildPythonPackage rec {
  pname = "transformers";
  version = "4.11.3";

  src = fetchFromGitHub {
    owner = "huggingface";
    repo = pname;
    rev = "v${version}";
    sha256 = "05xg992846zgfpp7jasx0d946g71r5vzmznfpdjf4vf5kwlhcjwv";
  };

  nativeBuildInputs = [ packaging ];

  propagatedBuildInputs = [
    cookiecutter
    filelock
    numpy
    protobuf
    pyyaml
    regex
    requests
    sacremoses
    tokenizers
    tqdm
    huggingface-hub
  ] ++ lib.optionals (pythonOlder "3.8") [ importlib-metadata ];

  # Many tests require internet access.
  doCheck = false;

  postPatch = ''
    sed -ri 's/tokenizers[=>]=[^"]+/tokenizers/g' setup.py src/transformers/dependency_versions_table.py
  '';

  pythonImportsCheck = [ "transformers" ];

  meta = with lib; {
    homepage = "https://github.com/huggingface/transformers";
    description = "State-of-the-art Natural Language Processing for TensorFlow 2.0 and PyTorch";
    changelog = "https://github.com/huggingface/transformers/releases/tag/v${version}";
    license = licenses.asl20;
    platforms = platforms.unix;
    maintainers = with maintainers; [ danieldk pashashocky ];
  };
}