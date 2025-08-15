const lookup = {
  "/":                  {path: "./web-src/index.html",                     type: "text/html"},
  "/script":            {path: "./web-src/script.js",                      type: "text/javascript"},
  "/pollock":           {path: "./build/javascript/pollock.js",            type: "text/javascript"},
  "/web-elements":      {path: "./web-src/interfaces/web-elements.js",     type: "text/javascript"},
  "/webgpu":            {path: "./web-src/interfaces/webgpu.js",           type: "text/javascript"},
  "/frame-buffer":      {path: "./web-src/interfaces/frame-buffer.js",     type: "text/javascript"},
  "/surface":           {path: "./web-src/interfaces/surface.js",          type: "text/javascript"},
  "/graphics-context":  {path: "./web-src/interfaces/graphics-context.js", type: "text/javascript"},
  "/pollock.core.wasm": {
    path: "./build/javascript/pollock.core.wasm", type: "application/wasm"},
};

Deno.serve(async req => {
    let path = new URL(req.url).pathname;
    console.log(`${req.method} ${path}`)
    switch (req.method) {
      case "GET":
        if (!lookup[path]) return new Response("no", { status: 404 });
        const file = await Deno.open(lookup[path].path);
        return new Response(file.readable, {
          headers: {"content-type": lookup[path].type},
        })
      default:
        return new Response("WHAT!", { status: 501 });
    }
});
