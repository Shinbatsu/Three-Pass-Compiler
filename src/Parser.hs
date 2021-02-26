module Parser where

import Data.Map
import Data.List (elemIndex)

import AST
import Token

prior :: Map.Map String Int
prior = Map.fromList [("+", 1), ("-", 1), ("*", 2), ("/", 2)]

pass1 :: String -> AST
pass1 program = buildAST tokens