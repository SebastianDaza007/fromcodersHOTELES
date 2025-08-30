// src/middleware.ts
import { NextRequest, NextResponse } from 'next/server';

export async function middleware(req: NextRequest) {
  const pathname = req.nextUrl.pathname;

  // Example: get token from cookies (adjust cookie name as needed)
  const token = req.cookies.get('next-auth.session-token')?.value;

  // You may need to decode the token and check the user's role here.
  // For demonstration, we'll just check if the token exists.
  if (pathname.startsWith("/dashboard") && !token) {
    // If the user is not authenticated, redirect
    return NextResponse.redirect(new URL("/unauthorized", req.url));
  }

  return NextResponse.next();
}

export const config = {
  matcher: ['/dashboard', '/admin'], // Aplicar middleware a estas rutas
};
