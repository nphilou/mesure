{ lib
, buildPythonPackage
, fetchPypi
, ipython
, pytest
}:

buildPythonPackage rec {
  pname = "ipytest";
  version = "0.11.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "6f1a03b32e243fd331439fcef587b34a72c74aa91e7fb7fa9e0799c83ccbe331";
  };

  propagatedBuildInputs = [
    ipython
    pytest
  ];
}