{-# LANGUAGE OverloadedStrings #-}

module Lib
  ( fetch
  , getReqPath
  )
where

import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as BL
import qualified Data.ByteString.Char8 as B8
import qualified Data.ByteString.Lazy.Char8 as BL8
import Network.HTTP.Simple
import Network.HTTP.Types.Header as HTypes
import qualified Network.Wai as Wai (Request, responseLBS, Application, rawPathInfo, rawQueryString)

makeReq :: String -> IO Request
makeReq url =
  parseRequest $ "GET " ++ url

fetch :: String -> IO BL8.ByteString
fetch url =
  makeReq url
  >>= \ req -> httpLBS req
  >>= \ res -> return $ getResponseBody res
--
getReqPath :: Wai.Request -> String
getReqPath req = B8.unpack $ B8.concat [(Wai.rawPathInfo req), (Wai.rawQueryString req)]
