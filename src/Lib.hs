{-# LANGUAGE OverloadedStrings #-}

module Lib
  ( fetch
  ) where

import Data.ByteString.Lazy
import Network.HTTP.Simple
import Network.HTTP.Types.Header as HTypes

makeReq :: String -> IO Request
makeReq url =
  parseRequest $ "GET " ++ url

fetch :: String -> IO ByteString
fetch url =
  makeReq url
  >>= \ req -> httpLBS req
  >>= \ res -> return $ getResponseBody res
