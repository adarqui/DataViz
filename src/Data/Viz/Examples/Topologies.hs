module Data.Viz.Examples.Topologies (
 infra2014Map,
 infra2014Map'Misc,
 infra2014Map'Prod,
 infra2014Map'NonProd
) where

import qualified Data.Map as M

-- current infrastructure
infra2014Map =
 M.unions [infra2014Map'Misc, infra2014Map'Prod, infra2014Map'NonProd]

infra2014Map'Misc = M.fromList
 [
  ("chef",[]),
  ("logger",[]),
  ("ec-mas-1",[]),
  ("ec-slv-2",[]),
  ("rds-mas-1",[]),
  ("rds-slv-1",[]),
  ("rds-slv-2",[]),
  ("s3",[]),
  ("vpn",[])
 ]

infra2014Map'Prod = M.fromList
 [
  ("vpn",["chef"]),
  ("rds-mas-1",["rds-slv-1","rds-slv-2"]),
  ("ec-mas-1",["ec-slv-1"]),
  ("client-1",["haproxy-1","download-1","haproxy-2","download-2"]),
  ("client-2",["haproxy-1","download-1","haproxy-2","download-2"]),
  ("client-3",["haproxy-1","download-1","haproxy-2","download-2"]),
  ("client-4",["haproxy-1","download-1","haproxy-2","download-2"]),
  ("client-5",["haproxy-1","download-1","haproxy-2","download-2"]),
  ("download-1",["rds-mas-1","ec-mas-1","chef","s3"]),
  ("download-2",["rds-mas-1","ec-mas-1","chef","s3"]),
  ("web-1",["rds-mas-1","rds-slv-1","rds-slv-2","ec-mas-1","chef","s3"]),
  ("web-2",["rds-mas-1","rds-slv-1","rds-slv-2","ec-mas-1","chef","s3"]),
  ("web-3",["rds-mas-1","rds-slv-1","rds-slv-2","ec-mas-1","chef","s3"]),
  ("web-4",["rds-mas-1","rds-slv-1","rds-slv-2","ec-mas-1","chef","s3"]),
  ("web-5",["rds-mas-1","rds-slv-1","rds-slv-2","ec-mas-1","chef","s3"]),
  ("worker-1",["rds-mas-1","ec-mas-1","s3"]),
  ("worker-2",["rds-mas-1","ec-mas-1","s3"]),
  ("worker-3",["rds-mas-1","ec-mas-1","s3"]),
  ("worker-4",["rds-mas-1","ec-mas-1","s3"]),
  ("worker-5",["rds-mas-1","ec-mas-1","s3"]),
  ("worker-6",["rds-mas-1","ec-mas-1","s3"])
 ]


infra2014Map'NonProd = M.fromList
 [
  ("rds-nonprod", []),
  ("beta-multi",["rds-nonprod","chef","s3"]),
  ("qa-multi",["rds-nonprod","chef","s3"]),
  ("alpha-multi",["rds-nonprod","chef","s3"]),
  ("dev-multi",["rds-nonprod","chef","s3"])
 ]
