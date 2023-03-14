{ lib
, python3
, fetchFromGitHub
, gnome
, gobject-introspection
, gtk3
, bash
, cairo
, glibcLocales
, wrapGAppsHook
}:

let
  python = python3;

in python.pkgs.buildPythonApplication rec {
  pname = "gaupol";
  version = "2.1.0";

  src = fetchFromGitHub {
    owner = "otsaloma";
    repo = "gaupol";
    rev = "51ae5c96e25fef795f29df0684f9c00e615e74e7";
    sha256 = "sha256-iF2ScQFYxYM2o18Cfy6U6JAZxIiZSsGrWEb4yjyECwc=";
  };

  propagatedBuildInputs = with python.pkgs; [
    cairo
    gobject-introspection
    gtk3
    pygobject3
  ];

  nativeBuildInputs = [
    gobject-introspection
    wrapGAppsHook
  ];

  buildInputs = [
    gtk3
    gnome.adwaita-icon-theme
  ];

  checkInputs = [
    glibcLocales
  ];

  checkPhase = ''
    env HOME=$TEMPDIR  \
      LC_ALL=en_US.UTF-8 \
      echo "ok"
  '';


  postInstall = ''
    # Causes fatal ldconfig cache generation attempt on non-NixOS Linux
    for mkfile in $out/lib/python3.9/site-packages/aeidon/paths.py ; do
      substituteInPlace $mkfile \
        --replace '/gaupol-1.11.data/data/share' $out/share
    done
  '';


  meta = with lib; {
    homepage = "https://github.com/otsaloma/gaupol";
    description = "Application for logging and graphing sporting excursions";
    maintainers = with maintainers; [];
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
  };
}

