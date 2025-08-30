// src/app/api/auth/[...nextauth]/route.ts
import NextAuth, { type AuthOptions, type User as NextAuthUser } from "next-auth";
import CredentialsProvider from "next-auth/providers/credentials";
import bcrypt from "bcrypt"; // Usamos bcryptjs
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

// Extiende el tipo User para incluir 'role'
declare module "next-auth" {
  interface User {
    role?: string;
  }
}

const ADMIN_EMAIL = "admin@example.com"; // Coloca aquí el email correcto
const ADMIN_PASSWORD_HASH = "$2a$10$J9g3TAs.dG0bZk3tQeQvbeD0EGasHLBhOa8OQLHdyMlmMts3bt2eC"; // Ejemplo de hash generado con bcryptjs

export const authOptions: AuthOptions = {
  session: { strategy: "jwt" },
  providers: [
    CredentialsProvider({
      name: "Administrador",
      credentials: {
        email: { label: "Email", type: "text" },
        password: { label: "Contraseña", type: "password" },
      },
      async authorize(credentials) {
        if (!credentials?.email || !credentials.password) {
          throw new Error("Faltan credenciales");
        }

        // Verifica el email en la base de datos
        const user = await prisma.user.findUnique({
          where: { email: credentials.email },
        });

        if (!user) {
          throw new Error("Email incorrecto");
        }

        // Compara la contraseña con el hash guardado en la base de datos
        const isValid = await bcrypt.compare(credentials.password, user.password);
        if (!isValid) {
          throw new Error("Contraseña incorrecta");
        }

        // Devuelves los datos del usuario con la propiedad 'role' desde la base de datos
        return { id: user.id.toString(), name: user.email, email: user.email, role: user.role }; // Agregamos el rol
      },
    }),
  ],
  pages: { signIn: "/admin/auth" },
  secret: "temporal-dev-secret", // Clave secreta para el entorno de desarrollo
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.email = user.email;
        token.role = user.role; // Agregamos el rol al JWT
      }
      return token;
    },
    async session({ session, token }) {
      if (token.email) {
        session.user.email = token.email as string;
      }
      if (token.role) {
        session.user.role = token.role as string; // Agregamos el rol a la sesión
      }
      return session;
    },
  },
};

const handler = NextAuth(authOptions);
export { handler as GET, handler as POST };
