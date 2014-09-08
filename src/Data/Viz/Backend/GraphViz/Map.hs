-- :( lmfao
module Data.Viz.Backend.GraphViz.Map (
 mapTo'SimpleGraph,
 listTo'SimpleGraph,
 mapTo'GroupGraph,
 listTo'GroupGraph,
 lr,
 tb
) where

import qualified Data.Map as M

mapTo'SimpleGraph :: String -> String -> M.Map String [String] -> String
mapTo'SimpleGraph t opts m = listTo'SimpleGraph t opts (M.toList m)

listTo'SimpleGraph :: String -> String -> [(String,[String])] -> String
listTo'SimpleGraph t opts m = "digraph g {\n" ++ title t ++ opts ++ concatenated ++ "}\n"
 where
  nodes =
   map
    (\(key,adjacencies) -> map (\adjacency -> "\""++key++"\"->\""++adjacency++"\";\n") adjacencies) m
  concatenated = concat $ concat nodes


mapTo'GroupGraph :: String -> String -> M.Map String String -> M.Map String Double -> M.Map String [String] -> String
mapTo'GroupGraph t opts colors sizes m = listTo'GroupGraph t opts (M.toList colors) (M.toList sizes) (M.toList m)

listTo'GroupGraph :: String -> String -> [(String,String)] -> [(String,Double)] -> [(String,[String])] -> String
listTo'GroupGraph t opts colors sizes m = "digraph g {\n" ++ title t ++ opts ++ colors' ++ sizes' ++ concatenated ++ "\n}"
 where
  sizes' = concat $ map (\(group,size) -> "\""++group++"\" [size="++show size++"];\n") sizes 
  colors' = concat $ map (\(group,color) -> "\""++group++"\" [style=filled, fillcolor ="++color++", color="++color++"];\n") colors
  nodes =
   map
    (\(key,adjacencies) -> map (\el -> "\""++key++"\"->\""++el++"\";\n") adjacencies) m
  concatenated = concat $ concat nodes


title t = "graph [label=\""++ t ++"\", labelloc=t, fontsize=30];\n"
common opts = concat $ map (++ "\n") $ ["overlap=false;","bgcolor=transparent;","splines=true;","splines=spline;"] ++ opts
lr = common ["rankdir=LR;"]
tb = common ["rankdir=TB;"]
