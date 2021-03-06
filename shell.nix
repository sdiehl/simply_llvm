with (import ./nixpkgs.nix);

let
  ghc =
    haskell.packages.ghc7103.ghcWithHoogle (pkgs: with pkgs; [
      protolude
      dlist
      llvm-general-pure
      llvm-general
      libffi
      ansi-wl-pprint
      pretty
      GenericPretty
    ]);
in
  pkgs.stdenv.mkDerivation {
    name = "simply-llvm-env";
    buildInputs = [
      ghc llvm_35 clang_35
    ];
    shellHook = ''
      eval $(egrep ^export ${ghc}/bin/ghc)
      PS1='nix:\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]$(__git_ps1 "(%s)")\$ '
    '';
  }
