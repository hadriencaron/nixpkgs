{ lib, buildPythonPackage, fetchPypi }:
buildPythonPackage rec {
  pname = "svg.path";
  version = "5.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-CltSq7BGQNmC/3EI5N0wx4QDu0zZWMJLovCUdtXZIws=";
  };

  meta = with lib; {
    description = "SVG path objects and parser";
    homepage = "https://github.com/regebro/svg.path";
    license = licenses.mit;
    maintainers = with maintainers; [ goibhniu ];
  };
}
