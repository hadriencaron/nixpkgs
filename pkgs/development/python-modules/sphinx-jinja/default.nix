{ lib, buildPythonPackage, fetchPypi, isPy27, pbr, sphinx, sphinx-testing, nose, glibcLocales }:

buildPythonPackage rec {
  pname = "sphinx-jinja";
  version = "2.0.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-3lMY1InG1PaAqhIrp5kovE6t+kTTpTKS3ir+WI/+RAY=";
  };

  buildInputs = [ pbr ];
  propagatedBuildInputs = [ sphinx ];

  checkInputs = [ sphinx-testing nose glibcLocales ];

  checkPhase = lib.optionalString (!isPy27) ''
    # prevent python from loading locally and breaking namespace
    mv sphinxcontrib .sphinxcontrib
  '' + ''
    # Zip (epub) does not support files with epoch timestamp
    LC_ALL="en_US.UTF-8" nosetests -e test_build_epub
  '';

  meta = with lib; {
    description = "Sphinx extension to include jinja templates in documentation";
    maintainers = with maintainers; [ ];
    license = licenses.mit;
  };
}
