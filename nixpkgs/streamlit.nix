{   lib, buildPythonApplication, fetchPypi, python3Packages
  , altair, astor, base58, blinker, boto3, botocore, click, enum-compat
  , future, pillow, protobuf, requests, toml, tornado, tzlocal, validators, watchdog
  , jinja2, setuptools, buildPythonPackage, cachetools, GitPython, packaging, pyarrow,
  ipykernel,
  ipywidgets,
  traitlets,
  numpy,
  pytest,
}:
let
  pydeck = buildPythonPackage rec {
    pname = "pydeck";
    version = "0.6.1";

    src = fetchPypi {
      inherit pname version;
      sha256 = "1l18iy3l6cgqlxwf9bvqijy494hx4hsnj1nm9i2pabz94i24hcd4"; 
    };

    doCheck = false; # I don't know how to tell it where to find pytest
    nativeBuildInputs =  [
      pytest
    ];
    propagatedBuildInputs =  [
      ipykernel
      ipywidgets
      traitlets
      jinja2
      numpy
    ];
  };
in
buildPythonPackage rec {
  pname = "streamlit";
  version = "0.79.0";
  format = "wheel"; # the only distribution available

  src = fetchPypi {
    inherit pname version format;
    sha256 = "085br2yi5l4xrb12bn8iykw10fmix5jy80ycl1s53qgynl0wkhim"; 
#    sha256 = "1ay2xr6vw57haag8gq87akmbh80iblcq535i2wialbzgs4adgqrh";
  };

  propagatedBuildInputs = [
    altair astor base58 blinker boto3 botocore click enum-compat
    future pillow protobuf requests toml tornado tzlocal validators watchdog
    jinja2 setuptools cachetools GitPython packaging pyarrow pydeck
  ];

  postInstall = ''
      rm $out/bin/streamlit.cmd # remove windows helper
  '';

  meta = with lib; {
    homepage = "https://streamlit.io/";
    description = "The fastest way to build custom ML tools";
    maintainers = with maintainers; [ yrashk ];
    license = licenses.asl20;
  };

}
