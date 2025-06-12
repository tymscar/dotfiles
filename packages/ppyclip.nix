{ pkgs }:

pkgs.python313Packages.buildPythonPackage rec {
  pname = "pyclip";
  version = "0.7.0";
  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "sha256-V2AgR6TOq3Cb3NQvPd5kSaM0m5XBYVTP3OJzdqIHJJE=";
  };
  doCheck = false;
  postPatch = ''
    # setup.py expects docs/README.md, but the sdist does not contain it.
    # Point it to README.md that *is* present.
    substituteInPlace setup.py \
      --replace "docs/README.md" "README.md"
  '';
}
