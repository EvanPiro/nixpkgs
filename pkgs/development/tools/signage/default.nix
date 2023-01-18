{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "signage";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "EvanPiro";
    repo = pname;
    rev = "d4358dbdfa7b67d4dd9d2741a33877bfd09a7138";
    hash = "sha256-y+j0Id5qwsST0KuKEQteaWGR60sJm0WCIg13iBewqKM=";
  };

  # cargoSha256 = lib.fakeSha256;
  cargoSha256 = "sha256-+s667FLR2YerzGk5iKLecr2cZh8O/fZy72QCtgHwyRc=";

  meta = with lib; {
    description = "Command-line tool built in rust";
    homepage = "https://github.com/EvanPiro/signage";
    license = licenses.mit;
    maintainers = [ ];
  };
}
