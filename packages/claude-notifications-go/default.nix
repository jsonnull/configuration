{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "claude-notifications-go";
  version = "1.36.7";

  src = fetchFromGitHub {
    owner = "777genius";
    repo = "claude-notifications-go";
    rev = "v${version}";
    hash = "sha256-fcLO7+E7oWI1YOwiB6fixnEBQ+pxntDFJ0FrkNEt+Fo=";
  };

  vendorHash = "sha256-uxkp08xQ0BrCcbmNFrG0k1DUFEoywSC3RVSvWno8gbk=";

  postInstall = ''
    mkdir -p $out/share/claude-notifications
    cp -r $src/sounds/* $out/share/claude-notifications/
    cp $src/claude_icon.png $out/share/claude-notifications/
  '';

  meta = {
    description = "Smart notifications plugin for Claude Code";
    homepage = "https://github.com/777genius/claude-notifications-go";
    license = lib.licenses.mit;
    mainProgram = "claude-notifications";
  };
}
