with import <nixpkgs> {
  overlays =  [
    (self: super:
    let
      lib = super.lib;
    in rec {
      python38 = super.python38.override {
        packageOverrides = self: super: {
          beautifulsoup4 = super.beautifulsoup4.overrideAttrs (old: {
            propagatedBuildInputs = lib.remove super.lxml old.propagatedBuildInputs;
          });
        };
      };
      python38Packages = python38.pkgs;
    })
  ];
};

(
  python38.withPackages (
    ps: with ps; [
      numpy
      scikitlearn
      pandas
      jupyter
      spacy
      streamlit
      seaborn
    ]
  )
).env
