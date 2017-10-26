{-# LANGUAGE OverloadedStrings #-}

module GatewayConfig
  ( load
  , matchRoute
  ) where

import Data.Aeson
import qualified Data.ByteString.Char8 as BS
import qualified Data.ByteString.UTF8 as UTF8
import Data.Maybe
import qualified Data.Yaml as Y

data GatewayConfig = GatewayConfig {
  testvalue :: String,
  routes :: [Route]
} deriving (Show)

instance Y.FromJSON GatewayConfig where
  parseJSON (Object v) = GatewayConfig <$> v .: "testvalue"
                                       <*> v .: "routes"
  parseJSON _ = error "Can't parse GatewayConfig from YAML."

data Route = Route {
  url :: String,
  flow :: [String]
} deriving (Show)

instance Y.FromJSON Route where
  parseJSON (Object v) = Route <$> v .: "url"
                               <*> v .: "flow"
  parseJSON _ = error "Can't parse Route from YAML."

load :: IO GatewayConfig
load =
  BS.readFile "gateway_config.yaml"
  >>= \ content -> case (Y.decode content :: Maybe GatewayConfig) of
    Just x -> return x
    Nothing -> return (GatewayConfig "" [])

matchRoute :: String -> [Route] -> Route
matchRoute needle xs = head [x | x <- xs, url x == needle]
