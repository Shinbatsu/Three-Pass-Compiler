module Generator (pass3) where

import AST

pass3 :: AST -> [String]
pass3 ast = case ast of
  Imm n     -> ["IM " ++ show n, "PU"]
  Arg n     -> ["AR " ++ show n, "PU"]
  Add a b   -> compileBin a b "AD"
  Sub a b   -> compileBin a b "SU"
  Mul a b   -> compileBin a b "MU"
  Div a b   -> compileBin a b "DI"
  where
    compileBin a b op =
      pass3 a ++ pass3 b ++ ["PO", "SW", "PO", op, "PU"]
