{
  stdenv,
  lib,
  fetchurl,
  gnum4,
  gitUpdater,
}:

stdenv.mkDerivation rec {
  pname = "adns";
  version = "1.6.1";

  src = fetchurl {
    urls = [
      "https://www.chiark.greenend.org.uk/~ian/adns/ftp/adns-${version}.tar.gz"
      "mirror://gnu/adns/adns-${version}.tar.gz"
    ];
    hash = "sha256-cTizeJt1Br1oP0UdT32FMHepGAO3s12G7GZ/D5zUAc0=";
  };

  nativeBuildInputs = [ gnum4 ];

  configureFlags = lib.optional stdenv.hostPlatform.isStatic "--disable-dynamic";

  preConfigure = lib.optionalString stdenv.hostPlatform.isDarwin "sed -i -e 's|-Wl,-soname=$(SHLIBSONAME)||' configure";

  # Autogenerated headers miss interdependencies in Makefile, fail parallel build:
  #  https://debbugs.gnu.org/cgi/bugreport.cgi?bug=51329
  enableParallelBuilding = false;

  # https://www.mail-archive.com/nix-dev@cs.uu.nl/msg01347.html for details.
  doCheck = false;

  postInstall =
    let
      suffix = lib.versions.majorMinor version;
    in
    lib.optionalString stdenv.hostPlatform.isDarwin ''
      install_name_tool -id $out/lib/libadns.so.${suffix} $out/lib/libadns.so.${suffix}
    '';

  # darwin executables fail, but I don't want to fail the 100-500 packages depending on this lib
  doInstallCheck = !stdenv.hostPlatform.isDarwin;
  installCheckPhase = ''
    set -eo pipefail

    for prog in $out/bin/*; do
      $prog --help > /dev/null && echo $(basename $prog) shows usage
    done
  '';

  passthru.updateScript = gitUpdater {
    url = "https://www.chiark.greenend.org.uk/ucgi/~ianmdlvl/githttp/adns.git";
    rev-prefix = "adns-";
  };

  meta = with lib; {
    homepage = "http://www.chiark.greenend.org.uk/~ian/adns/";
    description = "Asynchronous DNS Resolver Library";
    license = licenses.lgpl2;

    platforms = platforms.unix;
  };
}
