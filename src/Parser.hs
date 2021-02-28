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

    parseExpr :: [String] -> [Token] -> [AST]
    parseExpr vars = go [] []
      where
        go out ops [] = out
        go out ops (TInt n : ts) = go (Imm n : out) ops ts
        go out ops (TStr s : ts)
          | s `elem` vars =
              let Just idx = elemIndex s vars
              in go (Arg idx : out) ops ts
          | otherwise = error $ "Unknown var " ++ s
        go out ops (TChar '(' : ts) = go out ('(':ops) ts
        go out ops (TChar ')' : ts) =
          let (out', ops') = popUntilParen out ops
          in go out' (tail ops') ts
        go out ops (TChar op : ts)
          | [op] `Map.member` prior =
              let (out', ops') = popWhile (\o -> o /= '(' && prec o >= prec op) out ops
              in go out' (op:ops') ts
        go out ops (_:ts) = go out ops ts

        prec o = Map.findWithDefault 0 [o] prior

        popUntilParen out (o:ops)
          | o == '(' = (out, o:ops)
          | otherwise =
              let (x:y:ys) = out
              in popUntilParen (combine o y x:ys) ops

        popWhile _ out [] = (out, [])
        popWhile cond out (o:ops)
          | cond o =
              let (x:y:ys) = out
              in popWhile cond (combine o y x : ys) ops
          | otherwise = (out, o:ops)

        combine op a b = case op of
          '+' -> Add a b
          '-' -> Sub a b
          '*' -> Mul a b
          '/' -> Div a b
