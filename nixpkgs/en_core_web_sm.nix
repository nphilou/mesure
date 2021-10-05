{ stdenv,
fetchurl,
buildPythonPackage,
spacy,
}:

buildPythonPackage rec {
  pname = "en_core_web_sm";
  version = "3.1.0";

  src = fetchurl {
    url = "https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-3.0.0/en_core_web_sm-3.0.0.tar.gz";
#    sha256 = "0q3nz1q4nmj58s5f5h4n43w4pcfai8n51vgr9w7ckrhiappcn97n";
    sha256 = "0risizvzkicffw7vgrj92z23dfb7zvvzihqgvjcrx8989b7b6wq6";
  };

  propagatedBuildInputs = [ spacy ];
}
