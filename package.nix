{
  lib,
  rustPlatform,
  pkg-config,
  openssl,
  perl,
}:

rustPlatform.buildRustPackage {
  pname = "ironclaw";
  version = "0.16.1";

  src = lib.cleanSource ./.;

  cargoHash = "sha256-UYfOvBeJfEpzgapUprXfDlCeOtZGqj56nfVPtErkjO8=";

  nativeBuildInputs = [
    pkg-config
    perl # needed by openssl-sys
  ];

  buildInputs = [
    openssl
  ];

  # libsql-sys bundles its own SQLite; skip trying to link system sqlite
  LIBSQLITE3_SYS_BUNDLED = "1";

  # Tests require network / database access; skip in sandbox build
  doCheck = false;

  meta = {
    description = "Secure personal AI assistant that protects your data and expands its capabilities on the fly";
    homepage = "https://github.com/nearai/ironclaw";
    license = with lib.licenses; [ mit asl20 ];
    mainProgram = "ironclaw";
  };
}
