{ inputs, ... }:

{
  imports = [ inputs.private.nixosModules.default ];
}
