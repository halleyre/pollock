const lookup = {
  "/":                {path: "./web-src/index.html",  type: "text/html"},
  "/script":          {path: "./web-src/script.js",   type: "text/javascript"},
  "/pollock":         {path: "./pkg/pollock.js",      type: "text/javascript"},
  "/pollock_bg.wasm": {path: "./pkg/pollock_bg.wasm", type: "application/wasm"},
};

Deno.serve(async req => {
    let path = new URL(req.url).pathname;
    console.log(`${req.method} ${path}`)
    switch (req.method) {
      case "GET":
        const file = await Deno.open(lookup[path].path);
        return new Response(file.readable, {
          headers: {"content-type": lookup[path].type},
        })
      default:
        return new Response("WHAT!", { status: 501 });
    }
});
