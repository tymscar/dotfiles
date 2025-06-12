{ pkgs }:

let
  ppyclip = import ./ppyclip.nix { inherit pkgs; };
in
pkgs.python313Packages.buildPythonPackage rec {
  pname = "daktari";
  version = "0.0.275";
  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "sha256-dr5BCflThM0gP/zMtgh1cTz0srCPkF+3h1PWeXZIh1M=";
  };
  doCheck = false;
  format = "pyproject"; 
  dontCheckRuntimeDeps = true;
  propagatedBuildInputs = with pkgs.python313Packages; [
    ansicolors
    distro
    pyfiglet
    importlib-resources
    packaging
    setuptools
    requests
    responses
    semver
    python-hosts
    tabulate
    types-tabulate
    pyyaml
    types-pyyaml
    requests-unixsocket
    dpath
    pyopenssl
    types-pyopenssl
    ppyclip
    urllib3
    pyobjc-core
    pyobjc-framework-Cocoa
  ];
}
