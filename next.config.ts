// filepath: /ing/sis3/fromcodersHOTELES/next.config.ts
import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  async rewrites() {
    return [
      {
        source: "/admin/:slug*",
        destination: "/admin/:slug*",
      },
    ];
  },
};

export default nextConfig;