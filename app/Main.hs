{-# LANGUAGE OverloadedStrings #-}

module Main where

import Lib
import qualified Data.ByteString.Lazy       as BL  (unpack)
import qualified Data.ByteString.Lazy.Char8 as BL8 (pack)
import Network.Wai (Request, responseLBS, Application, rawPathInfo, rawQueryString)
import Network.Wai.Handler.Warp (run)
import Network.HTTP.Simple
import Network.HTTP.Types (status200)
import Network.HTTP.Types.Header (hContentType)

main :: IO ()
main = do
  let port = 9000
  putStrLn $ "Listening on port " ++ show port
  run port app

app :: Application
app req f = do
  let baseUrl = "http://mattmoore.io"
  response <- fetch (baseUrl ++ (getReqPath req))
  f $ responseLBS status200 [(hContentType, "text/plain")] $ response
