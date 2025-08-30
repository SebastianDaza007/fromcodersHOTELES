/*
  Warnings:

  - You are about to drop the `Deposito` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `DetalleMovimiento` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Insumo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `InsumosPorDeposito` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `MovimientoStock` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `TipoMovimiento` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."DetalleMovimiento" DROP CONSTRAINT "DetalleMovimiento_id_insumos_deposito_fkey";

-- DropForeignKey
ALTER TABLE "public"."DetalleMovimiento" DROP CONSTRAINT "DetalleMovimiento_id_mov_stock_fkey";

-- DropForeignKey
ALTER TABLE "public"."InsumosPorDeposito" DROP CONSTRAINT "InsumosPorDeposito_id_deposito_fkey";

-- DropForeignKey
ALTER TABLE "public"."InsumosPorDeposito" DROP CONSTRAINT "InsumosPorDeposito_id_insumo_fkey";

-- DropForeignKey
ALTER TABLE "public"."MovimientoStock" DROP CONSTRAINT "MovimientoStock_id_deposito_fkey";

-- DropForeignKey
ALTER TABLE "public"."MovimientoStock" DROP CONSTRAINT "MovimientoStock_id_tipo_mov_fkey";

-- DropTable
DROP TABLE "public"."Deposito";

-- DropTable
DROP TABLE "public"."DetalleMovimiento";

-- DropTable
DROP TABLE "public"."Insumo";

-- DropTable
DROP TABLE "public"."InsumosPorDeposito";

-- DropTable
DROP TABLE "public"."MovimientoStock";

-- DropTable
DROP TABLE "public"."TipoMovimiento";

-- DropTable
DROP TABLE "public"."User";

-- CreateTable
CREATE TABLE "public"."insumo" (
    "id_insumo" SERIAL NOT NULL,
    "nom_insumo" TEXT NOT NULL,

    CONSTRAINT "insumo_pkey" PRIMARY KEY ("id_insumo")
);

-- CreateTable
CREATE TABLE "public"."deposito" (
    "id_deposito" SERIAL NOT NULL,
    "nom_deposito" TEXT NOT NULL,

    CONSTRAINT "deposito_pkey" PRIMARY KEY ("id_deposito")
);

-- CreateTable
CREATE TABLE "public"."insumos_por_deposito" (
    "id_insumos_deposito" SERIAL NOT NULL,
    "id_insumo" INTEGER NOT NULL,
    "id_deposito" INTEGER NOT NULL,
    "stock_insumo" INTEGER NOT NULL,

    CONSTRAINT "insumos_por_deposito_pkey" PRIMARY KEY ("id_insumos_deposito")
);

-- CreateTable
CREATE TABLE "public"."detalle_movimiento" (
    "id_detalle_mov" SERIAL NOT NULL,
    "id_insumos_deposito" INTEGER NOT NULL,
    "id_mov_stock" INTEGER NOT NULL,
    "cantidad_mov" INTEGER NOT NULL,

    CONSTRAINT "detalle_movimiento_pkey" PRIMARY KEY ("id_detalle_mov")
);

-- CreateTable
CREATE TABLE "public"."movimiento_stock" (
    "id_mov_stock" SERIAL NOT NULL,
    "id_deposito" INTEGER NOT NULL,
    "id_tipo_mov" INTEGER NOT NULL,
    "fecha_registro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "movimiento_stock_pkey" PRIMARY KEY ("id_mov_stock")
);

-- CreateTable
CREATE TABLE "public"."tipo_movimiento" (
    "id_tipo_mov" SERIAL NOT NULL,
    "nombre_mov" TEXT NOT NULL,

    CONSTRAINT "tipo_movimiento_pkey" PRIMARY KEY ("id_tipo_mov")
);

-- CreateTable
CREATE TABLE "public"."user" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" TEXT NOT NULL DEFAULT 'user',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "public"."user"("email");

-- AddForeignKey
ALTER TABLE "public"."insumos_por_deposito" ADD CONSTRAINT "insumos_por_deposito_id_insumo_fkey" FOREIGN KEY ("id_insumo") REFERENCES "public"."insumo"("id_insumo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."insumos_por_deposito" ADD CONSTRAINT "insumos_por_deposito_id_deposito_fkey" FOREIGN KEY ("id_deposito") REFERENCES "public"."deposito"("id_deposito") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."detalle_movimiento" ADD CONSTRAINT "detalle_movimiento_id_insumos_deposito_fkey" FOREIGN KEY ("id_insumos_deposito") REFERENCES "public"."insumos_por_deposito"("id_insumos_deposito") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."detalle_movimiento" ADD CONSTRAINT "detalle_movimiento_id_mov_stock_fkey" FOREIGN KEY ("id_mov_stock") REFERENCES "public"."movimiento_stock"("id_mov_stock") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."movimiento_stock" ADD CONSTRAINT "movimiento_stock_id_deposito_fkey" FOREIGN KEY ("id_deposito") REFERENCES "public"."deposito"("id_deposito") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."movimiento_stock" ADD CONSTRAINT "movimiento_stock_id_tipo_mov_fkey" FOREIGN KEY ("id_tipo_mov") REFERENCES "public"."tipo_movimiento"("id_tipo_mov") ON DELETE RESTRICT ON UPDATE CASCADE;
