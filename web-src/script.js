document.getElementById("aye").innerHTML = "start the rescue helicopter";
// wee bit of debug bracketing

/* ------------ *
 * Web Assembly *
 * ------------ */ 
import { legocity } from "/pollock";
legocity("a man");

/* ------ *
 * WebGPU *
 * ------ */
const canvas = document.getElementById("life")

if (!navigator.gpu) throw new Error("WebGPU unsupported by broswer");

// native implemetation
const adapter = await navigator.gpu.requestAdapter();
if (!adapter) throw new Error("GPUAdapter not found.");

// logical resource
const device = await adapter.requestDevice();

const context = canvas.getContext("webgpu");
const canvasFormat = navigator.gpu.getPreferredCanvasFormat();
context.configure({
  device: device,
  format: canvasFormat,
});

const encoder = device.createCommandEncoder();
const pass = encoder.beginRenderPass({
  colorAttachments: [{
    view: context.getCurrentTexture().createView(),
    loadOp: "clear",
    clearValue: { r: 0, g: 0.3, b: 0, a: 1 },
    storeOp: "store",
  }]
});
pass.end();

device.queue.submit([encoder.finish()]);

// probs success
document.getElementById("bee").innerHTML = "build the helicopter";
