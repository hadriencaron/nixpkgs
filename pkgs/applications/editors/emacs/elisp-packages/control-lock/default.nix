{ lib, stdenv, fetchurl, fetchgit }:

stdenv.mkDerivation {
  name = "control-lock";

  # src = fetchurl {
  #   url = "https://github.com/emacsmirror/emacswiki.org/blob/185fdc34fb1e02b43759ad933d3ee5646b0e78f8/control-lock.el";
  #   sha256 = "0dv2w097vsdb3wx1nxp67haxsrqdgsiz7zy6davcyvdnpy18psxa";
  # };

  src = fetchgit {
      name="control-lock-gitmirror";
      branchName="master";
      rev="185fdc34fb1e02b43759ad933d3ee5646b0e78f8";
      url="https://github.com/emacsmirror/emacswiki.org.git" ;
      hash="sha256-v5SuorXtThcQnibzJK5A/nRxNdPfFWs3j2m3TH7fNWE=";
      filter="control-lock.el";
  };

#  src = fetchFromGitHub {
#      rev="185fdc34fb1e02b43759ad933d3ee5646b0e78f8";
#      url="https://github.com/emacsmirror/emacswiki.org.git" ;
#      hash="sha256-EaZT+pq2z0ldkScVaTWXAjFXg/UjYcWSRqCtzT81zf4=";
#      filter="control-lock.el";
#  };


  dontUnpack = true;

  installPhase = ''
    echo "INSTALL PHASE !!! $src"
    install -d $out/share/emacs/site-lisp
    install $src/control-lock.el $out/share/emacs/site-lisp/control-lock.el
  '';

  meta = {
    description = "Like caps-lock, but for your control key.  Give your pinky a rest!";
    homepage = "https://www.emacswiki.org/emacs/control-lock.el";
    platforms = lib.platforms.all;
  };
}
