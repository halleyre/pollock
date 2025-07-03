Deno.serve(async req => {
    let path = new URL(req.url).pathname;
    console.log(path);
    switch (path) {
      case "/":
      case "/index.html":
        path = "./web-src/index.html";
        break;
      case "/script.js":
        path = "./web-src/script.js";
        break;
      case "/pkg/pollock.js":
        path = "./pkg/pollock.js";
        break;
      default:
        return new Response("Not Found", { status: 404 });
    }
    const file = await Deno.open(path);
    return new Response(file.readable)
});
