{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_interpreter (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "interpreter"
version :: Version
version = Version [1,1,0,4] []

synopsis :: String
synopsis = ""
copyright :: String
copyright = "2021 Shinbatsu"
homepage :: String
homepage = ""
