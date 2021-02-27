module Parser where

import Data.Map
import Data.List (elemIndex)

import AST
import Token

prior :: Map.Map String Int
prior = Map.fromList [("+", 1), ("-", 1), ("*", 2), ("/", 2)]

pass1 :: String -> AST
pass1 program = buildAST tokens
  where
    tokens = tokenize program
    buildAST :: [Token] -> AST
    buildAST toks =
      let (vars, bodyTokens) = parseVars toks
          output = parseExpr vars (TChar '(' : bodyTokens ++ [TChar ')'])
      in head output

    parseVars :: [Token] -> ([String], [Token])
    parseVars (TChar '[' : rest) = go rest []
      where
        go (TChar ']' : xs) acc = (reverse acc, xs)
        go (TStr s : xs) acc    = go xs (s:acc)
        go (_:xs) acc           = go xs acc
    parseVars xs = ([], xs)
