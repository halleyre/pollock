function handler(Request) {
  return new Response("Hello, World!");
}
Deno.serve(handler);
