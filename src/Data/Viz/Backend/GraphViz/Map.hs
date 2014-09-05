-- :( lmfao
module Data.Viz.Backend.GraphViz.Map (
 mapTo'SimpleGraph,
 listTo'SimpleGraph
) where

import qualified Data.Map as M

mapTo'SimpleGraph :: String -> M.Map String [String] -> String
mapTo'SimpleGraph t m = "digraph g {\n" ++ title t ++ concatenated ++ "\n}"
 where
  keys = M.keys m
  nodes =
   map
    (\key -> map (\el -> "\""++key++"\"->\""++el++"\";\n") $ adjacencies key) keys
  adjacencies key =
   map
    (\elem -> elem) $ (M.!) m key
  concatenated = concat $ concat nodes

listTo'SimpleGraph :: String -> [(String,[String])] -> String
listTo'SimpleGraph t m = "digraph g {\n" ++ title t ++ concatenated ++ "}\n"
 where
  concatenated = concat $ concat $ map (\(key,rest) -> map (\el -> "\""++key++"\"->\""++el ++"\";\n") rest) m

title t = "graph [label=\""++ t ++"\", labelloc=t, fontsize=30];\n"
