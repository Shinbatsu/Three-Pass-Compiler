module Main (compile) where

import Parser (pass1)
import Recucer (pass2)
import Generator (pass3)

compile :: String -> [String]
compile = pass3 . pass2 . pass1
