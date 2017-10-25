{-# LANGUAGE OverloadedStrings #-}

module Main where

import Lib
import Network.Wai (responseLBS, Application)
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
app req f =
  fetch "http://mattmoore.io" >>= \response ->
  f $ responseLBS status200 [(hContentType, "text/plain")] response
