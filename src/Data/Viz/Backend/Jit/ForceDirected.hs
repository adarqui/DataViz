{-# LANGUAGE OverloadedStrings, RecordWildCards #-}
module Data.Viz.Backend.Jit.ForceDirected (
 FDG (..),
 mapTo'FDG,
 mapTo'FDG'JSON
) where

import qualified Data.Map as M
import qualified Data.ByteString.Lazy as B

import Data.Aeson
import Control.Applicative
import Control.Monad

data FDG = FDG {
 _nodes :: [Node]
} deriving (Show, Read, Eq)

instance ToJSON FDG where
 toJSON (FDG _nodes) = object ["nodes" .= _nodes]


data Node = Node {
 _adjacencies :: [Edge],
 _nodeData :: NodeData,
 _id :: String,
 _name :: String
} deriving (Show, Read, Eq)

instance FromJSON Node where
 parseJSON (Object v) = Node <$>
  v .: "adjacencies" <*>
  v .: "data" <*>
  v .: "id" <*>
  v .: "name"
 parseJSON _ = mzero

instance ToJSON Node where
 toJSON (Node _adjacencies _nodeData _id _name) = object ["adjacencies" .= _adjacencies, "data" .= _nodeData, "id" .= _id, "name" .= _name]


data Edge = Edge {
 _nodeTo :: String,
 _nodeFrom :: String
} deriving (Show, Read, Eq)

instance FromJSON Edge where
 parseJSON (Object v) = Edge <$>
  v .: "nodeTo" <*>
  v .: "nodeFrom"
 parseJSON _ = mzero

instance ToJSON Edge where
 toJSON (Edge _nodeTo _nodeFrom) = object ["nodeTo" .= _nodeTo, "nodeFrom" .= _nodeFrom]


data NodeData = NodeData {
 _color :: String,
 _type :: String
} deriving (Show, Read, Eq)

instance FromJSON NodeData where
 parseJSON (Object v) = NodeData <$>
  v .: "$color" <*>
  v .: "$type"
 parseJSON _ = mzero

instance ToJSON NodeData where
 toJSON (NodeData _color _type) = object ["$color" .= _color, "$type" .= _type]


mapTo'FDG :: M.Map String [String] -> FDG
mapTo'FDG m = FDG { _nodes = nodes }
 where
  keys = M.keys m
  nodes =
   map
    (\key -> Node { _adjacencies = adjacencies key, _nodeData = defaultNodeData, _id = key, _name = key }) keys
  adjacencies key =
   map
    (\elem -> Edge { _nodeTo = elem, _nodeFrom = key }) $ (M.!) m key


mapTo'FDG'JSON :: FDG -> B.ByteString
mapTo'FDG'JSON fdg@FDG{..} = encode _nodes

defaultNodeData = NodeData {
 _color = "#835488",
 _type = "circle"
}
