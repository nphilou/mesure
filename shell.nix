with import <nixpkgs> {
  overlays =  [
    (self: super:
    let
      lib = super.lib;
    in rec {
      python39 = super.python39.override {
        packageOverrides = self: super: {
          beautifulsoup4 = super.beautifulsoup4.overrideAttrs (old: {
            propagatedBuildInputs = lib.remove super.lxml old.propagatedBuildInputs;
          });
        };
      };
      python39Packages = python39.pkgs;
    })
  ];
};

(
  python39.withPackages (
    ps: with ps; [
      numpy
      scikitlearn
      pandas
      jupyter
      spacy
    ]
  )
).env
