{
  description = ''B)asic|But-For U)tility Code/Programs (Usually Nim & With Unix/POSIX/Linux Context)'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."bu-main".dir   = "main";
  inputs."bu-main".owner = "nim-nix-pkgs";
  inputs."bu-main".ref   = "master";
  inputs."bu-main".repo  = "bu";
  inputs."bu-main".type  = "github";
  inputs."bu-main".inputs.nixpkgs.follows = "nixpkgs";
  inputs."bu-main".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}