export function getGpu() {
  if (!navigator.gpu) throw new Error("WebGPU unsupported by broswer");
  return 
}

// export type GpuPowerPreference = 'low-power' | 'high-performance';
// export interface GpuRequestAdapterOptions {
//   featureLevel?: string,
//   powerPreference?: GpuPowerPreference,
//   forceFallbackAdapter?: boolean,
//   xrCompatible?: boolean,
// }

export class Gpu {
  constructor(gpu) { this.gpu = gpu }
  async requestAdapter(options) {
    const adapter = await navigator.gpu.requestAdapter(options);
    if (!adapter) throw new Error("GPUAdapter not found.");

    return GpuAdapter(adapter)
  }
}

export class GpuAdapter {
  constructor(adapter) { this.adapter = adapter };
}
