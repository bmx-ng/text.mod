# Text.Bidi

Graphics-independent interface for optional Unicode bidirectional analysis.
`Text.SheenBidi` is the bundled implementation. Consumers capture the registered
provider during preparation and retain its paragraph results across reflow.
There is no dependency on SheenBidi, HarfBuzz, Max2D or a native bidi library here.

`ETextDirection.Auto` lets a consumer use an available provider. `Disabled`
explicitly bypasses it; `LeftToRight` and `RightToLeft` request a base direction.
See Text.SheenBidi for the UTF-16 range and visual-run contracts. Other providers
must implement the same paragraph-relative input and line-relative output
semantics, including line-end level resetting and script segmentation.
