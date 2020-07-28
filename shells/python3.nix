{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "python3";

  buildInputs = with pkgs.python38Packages; [
    pkgs.python38Full

    flake8
    pip
    pylint
    pytest
    virtualenv
  ];

  shellHook = ''
    SOURCE_DATE_EPOCH=$(date +%s)  # so that we can use python wheels
    YELLOW='\033[1;33m'
    NC="$(printf '\033[0m')"

    echo -e "''${YELLOW}Creating python environment...''${NC}"
    virtualenv --no-setuptools venv > /dev/null
    export PATH=$PWD/venv/bin:$PATH > /dev/null
    pip install -r requirements.txt > /dev/null
  '';
}
