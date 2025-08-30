-- CreateTable
CREATE TABLE "public"."Insumo" (
    "id_insumo" SERIAL NOT NULL,
    "nom_insumo" TEXT NOT NULL,

    CONSTRAINT "Insumo_pkey" PRIMARY KEY ("id_insumo")
);

-- CreateTable
CREATE TABLE "public"."Deposito" (
    "id_deposito" SERIAL NOT NULL,
    "nom_deposito" TEXT NOT NULL,

    CONSTRAINT "Deposito_pkey" PRIMARY KEY ("id_deposito")
);

-- CreateTable
CREATE TABLE "public"."InsumosPorDeposito" (
    "id_insumos_deposito" SERIAL NOT NULL,
    "id_insumo" INTEGER NOT NULL,
    "id_deposito" INTEGER NOT NULL,
    "stock_insumo" INTEGER NOT NULL,

    CONSTRAINT "InsumosPorDeposito_pkey" PRIMARY KEY ("id_insumos_deposito")
);

-- CreateTable
CREATE TABLE "public"."DetalleMovimiento" (
    "id_detalle_mov" SERIAL NOT NULL,
    "id_insumos_deposito" INTEGER NOT NULL,
    "id_mov_stock" INTEGER NOT NULL,
    "cantidad_mov" INTEGER NOT NULL,

    CONSTRAINT "DetalleMovimiento_pkey" PRIMARY KEY ("id_detalle_mov")
);

-- CreateTable
CREATE TABLE "public"."MovimientoStock" (
    "id_mov_stock" SERIAL NOT NULL,
    "id_deposito" INTEGER NOT NULL,
    "id_tipo_mov" INTEGER NOT NULL,
    "fecha_registro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MovimientoStock_pkey" PRIMARY KEY ("id_mov_stock")
);

-- CreateTable
CREATE TABLE "public"."TipoMovimiento" (
    "id_tipo_mov" SERIAL NOT NULL,
    "nombre_mov" TEXT NOT NULL,

    CONSTRAINT "TipoMovimiento_pkey" PRIMARY KEY ("id_tipo_mov")
);

-- CreateTable
CREATE TABLE "public"."User" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" TEXT NOT NULL DEFAULT 'user',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "public"."User"("email");

-- AddForeignKey
ALTER TABLE "public"."InsumosPorDeposito" ADD CONSTRAINT "InsumosPorDeposito_id_insumo_fkey" FOREIGN KEY ("id_insumo") REFERENCES "public"."Insumo"("id_insumo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."InsumosPorDeposito" ADD CONSTRAINT "InsumosPorDeposito_id_deposito_fkey" FOREIGN KEY ("id_deposito") REFERENCES "public"."Deposito"("id_deposito") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DetalleMovimiento" ADD CONSTRAINT "DetalleMovimiento_id_insumos_deposito_fkey" FOREIGN KEY ("id_insumos_deposito") REFERENCES "public"."InsumosPorDeposito"("id_insumos_deposito") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DetalleMovimiento" ADD CONSTRAINT "DetalleMovimiento_id_mov_stock_fkey" FOREIGN KEY ("id_mov_stock") REFERENCES "public"."MovimientoStock"("id_mov_stock") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."MovimientoStock" ADD CONSTRAINT "MovimientoStock_id_deposito_fkey" FOREIGN KEY ("id_deposito") REFERENCES "public"."Deposito"("id_deposito") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."MovimientoStock" ADD CONSTRAINT "MovimientoStock_id_tipo_mov_fkey" FOREIGN KEY ("id_tipo_mov") REFERENCES "public"."TipoMovimiento"("id_tipo_mov") ON DELETE RESTRICT ON UPDATE CASCADE;
