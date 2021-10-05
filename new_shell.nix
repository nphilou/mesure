with import <nixpkgs> {};

pkgs.mkShell {
  name = "env";
  buildInputs = [
    (python38.withPackages (
      ps: with ps; [
        pip
        pdfminer
        numpy
        scikitlearn
        pandas
        jupyter
        spacy
        (callPackage ./nixpkgs/en_core_web_sm.nix {})
        (callPackage ./nixpkgs/streamlit.nix {})
        # streamlit
        seaborn
        jsonlines
        pypdf2
      ]
    ))
    # (callPackage ./nixpkgs/streamlit.nix {})

#    pkgs.streamlit
  ];
}
