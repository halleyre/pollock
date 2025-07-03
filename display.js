const dimensions = {
  width: 640,
  height: 480,
};

// native implemetation
const adapter = await navigator.gpu.requestAdapter();
if (!adapter) {
  console.error("GPUAdapter not found.");
  Deno.exit(0);
}

// logical resource
const device = await adapter.requestDevice();
