{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "signage";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "EvanPiro";
    repo = pname;
    rev = "2c376ff04888a05e96f8148f1da68252b8ad8422";
    hash = "sha256-1nDymsdfFszkKh9QnW4MhlqxbHwgLGQCe8nweVADShY=";
  };

  # cargoSha256 = lib.fakeSha256;
  cargoSha256 = "sha256-ihsEBjvD6wLNWv+l7y6FA9HQP8v/xpDcc9+NYy+Nfk8=";

  meta = with lib; {
    description = "Command-line tool built in rust";
    homepage = "https://github.com/EvanPiro/signage";
    license = licenses.mit;
    maintainers = [ ];
  };
}
