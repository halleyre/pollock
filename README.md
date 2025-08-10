# pollock

deno, wasm and webgpu

Chromium (Dawn) webgpu blocklists my adreno gpu (https://issues.chromium.org/issues/42242119)
(can avoid with unsafe flags)

Deno (gfx-rs/wgpu) doesn't support my gpu either booo

## building
`wasm-pack build --target web`

## hosting
`deno task host`
