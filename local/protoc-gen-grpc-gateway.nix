{ pkgs }:

pkgs.buildGoModule rec {
  pname = "protoc-gen-grpc-gateway";
  version = "2.26.3"; # Example version

  src = pkgs.fetchFromGitHub {
    owner = "grpc-ecosystem";
    repo = "grpc-gateway";
    rev = "v${version}";
    sha256 = "sha256-e/TPCli2wXyzEpn84hZdtVaAmXJK+d0vMRLilXohiN8=";
  };

  vendorHash = "sha256-Des02yenoa6am0xIqto7xlOWHh44F5EBVEhi9t+v644=";

  subPackages = [ "protoc-gen-grpc-gateway" "protoc-gen-openapiv2" ];
}
