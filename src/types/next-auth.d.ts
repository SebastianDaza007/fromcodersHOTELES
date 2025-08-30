// src/types/next-auth.d.ts
import NextAuth from "next-auth";

declare module "next-auth" {
  interface Session {
    user: {
      email: string;
      role: string; // Agregamos la propiedad 'role'
    };
  }

  interface JWT {
    role: string; // También agregamos el rol al JWT
  }
}
