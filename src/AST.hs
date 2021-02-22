module AST (AST) where

data AST = Imm Int
         | Arg Int
         | Add AST AST
         | Sub AST AST
         | Mul AST AST
         | Div AST AST
         deriving (Eq, Show)
