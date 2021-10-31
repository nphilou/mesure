{ lib
, buildPythonPackage
, fetchPypi
, pyyaml
, pyzmq
, jsonschema
, ipython
, nose
}:

buildPythonPackage rec {
  pname = "yamlmagic";
  version = "0.2.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "c9a64977dd3f379530127a74a35dfc5b1a5ac82efb9a36d87a182d0c650a7205";
  };
  dontUseSetuptoolsCheck = true;

  propagatedBuildInputs = [
    pyyaml
    pyzmq
    jsonschema
    ipython
    nose
  ];
}