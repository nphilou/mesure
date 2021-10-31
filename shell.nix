with import <unstable> {};

(python38.withPackages (
    ps: with ps; [
      numpy
      scikitlearn
      pandas
      jupyter
      spacy
      streamlit
      pytorch
      ruamel-yaml
      scikitlearn
      scipy
      sentencepiece
      tables
      tensorflow # WithCuda
      # transformers
      wheel
      (callPackage ./nixpkgs/transformers.nix {})
      (callPackage ./nixpkgs/watermark.nix {})
      (callPackage ./nixpkgs/ipytest.nix {})
      (callPackage ./nixpkgs/yamlmagic.nix {})
      (callPackage ./nixpkgs/en_core_web_sm.nix {})
      (callPackage ./nixpkgs/streamlit.nix {})
      seaborn
      jsonlines
      pypdf2
      pdfminer
      nltk
    ]
  )
).env