module Reducer where

import AST

pass2 :: AST -> AST
pass2 ast = case ast of
  Add a b -> simplify Add (+) a b
  Sub a b -> simplify Sub (-) a b
  Mul a b -> simplify Mul (*) a b
  Div a b -> simplify Div div a b
  _       -> ast
  where
    simplify ctor op a b =
      let a' = pass2 a
          b' = pass2 b
      in case (a', b') of
        (Imm x, Imm y) -> Imm (op x y)
        _              -> ctor a' b'
