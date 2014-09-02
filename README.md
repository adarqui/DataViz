Data visualization stuff.

visualization backends
======================

jit -> 
--
1. Data.Viz.Backend.Jit.ForceDirected
2. http://philogb.github.io/jit
3. Force directed graph


misc examples
=============

```
infra2014Map
```

```
mapTo'FDG'JSON $ mapTo'FDG $ infra2014Map 
```

```
:set -XOverloadedStrings
import Data.Viz.Examples.Topologies
import Data.Viz.Backend.Jit.ForceDirected
import Data.Viz.Backend.Jit.ForceDirected.Example
import qualified Data.ByteString.Lazy.Char8 as B
let g = simpleGraph $ B.unpack $ mapTo'FDG'JSON $ mapTo'FDG $ infra2014Map
writeFile "/www/pub/test.js" g
```
