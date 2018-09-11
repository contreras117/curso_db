drop table if exists CARRITO;
drop table if exists ITEM_PROVEEDOR;
drop table if exists CARRITO_ITEM;
drop table if exists CLIENTE;
drop table if exists ITEM;
drop table if exists PROVEEDOR;
drop table if exists M_COMPRA;
drop table if exists M_PAGO;

/* Primero borro las tablas que tienen dependencias hacia otras tablas*/


/*===============================================*/
/* Table: CARRITO */
/*===============================================*/
create table CARRITO
(
	ca_ID Serial NOT NULL UNIQUE,
	ca_Cliente Int NOT NULL,
	ca_MCompra Int NOT NULL,
	ca_MPago Int NOT NULL,
	ca_NumItem Numeric(3) NOT NULL,
	ca_Direccion Varchar(120),
	ca_Comentario Varchar(300),
	ca_Tag Varchar(100),
	primary key (ca_ID)
);


/*===============================================*/
/* Table: ITEM */
/*===============================================*/
create table ITEM
(
	it_ID Serial NOT NULL UNIQUE,
	it_Nombre Varchar(60) NOT NULL,
	it_Descripcion Varchar(300) NOT NULL,
	it_Medidas Varchar(60) NOT NULL,
	it_Peso Varchar(15) NOT NULL,
	it_Foto Varchar(50),
	primary key (it_ID)
);


/*===============================================*/
/* Table: CLIENTE */
/*===============================================*/
create table CLIENTE
(
	cl_ID Serial NOT NULL UNIQUE,
	cl_Cuenta_Platzi Varchar(60) NOT NULL UNIQUE,
	cl_Nombre Varchar(60) NOT NULL,
	cl_FechaIni Timestamp NOT NULL,
	cl_Correo Varchar(60),
	cl_FechaNac Timestamp,
	cl_Preferencias Varchar(300),
	primary key (cl_ID)
);


/*===============================================*/
/* Table: M_COMPRA */
/*===============================================*/
create table M_COMPRA
(
	mc_ID Serial NOT NULL UNIQUE,
	mc_Codigo Numeric(15) NOT NULL UNIQUE,
	mc_Metodo Varchar(250) NOT NULL,
	mc_FechaIni Timestamp NOT NULL,
	mc_Direccion Varchar(120),
	primary key (mc_ID)
);


/*===============================================*/
/* Table: M_PAGO */
/*===============================================*/
create table M_PAGO
(
	mp_ID Serial NOT NULL UNIQUE,
	mp_Tipo Varchar(255) NOT NULL UNIQUE,
	mp_CodPasarela Varchar(15) NOT NULL,
	mp_Status Varchar(10) NOT NULL,
	mp_FechaExp Timestamp,
	primary key (mp_ID)
);


/*===============================================*/
/* Table: PROVEEDOR */
/*===============================================*/
create table PROVEEDOR
(
	pr_ID Serial NOT NULL UNIQUE,
	pr_RFC Varchar(15) NOT NULL UNIQUE comment 'RFC del proveedor',
	pr_Nombre Varchar(90) NOT NULL,
	pr_Descripcion Varchar(120) NOT NULL,
	pr_FechaIni Timestamp NOT NULL,
	pr_FechaCompra Timestamp,
	pr_MontoUCompra Numeric(7),
	pr_Moneda Varchar(5),
	primary key (pr_ID)
);


/*===============================================*/
/* Table: ITEM_PROVEEDOR */
/*===============================================*/
create table ITEM_PROVEEDOR
(
	ip_ItemID Int NOT NULL,
	ip_PrId Int NOT NULL,
	ip_Lote Varchar(10) NOT NULL,
	primary key (ip_ItemID, ip_PrId)
);


/*===============================================*/
/* Table: CARRITO_ITEM */
/*===============================================*/
create table CARRITO_ITEM
(
	ci_CarritoID Int NOT NULL,
	ci_ItemID Int NOT NULL,
	ci_Cantidad Numeric(3) NOT NULL,
	primary key (ci_CarritoID, ci_ItemID)
);



alter table CARRITO add constraint FK_Carrito_Cliente foreign key
(ca_Cliente) references (cl_ID) on delete restrict on update restrict;

alter table M_COMPRA add constraint FK_Carrito_MCompra foreign key
(ca_MCompra) references (mc_ID) on delete restrict on update restrict; 

alter table M_PAGO add constraint FK_Carrito_MPago foreign key
(ca_MPago) references (mp_ID) on delete restrict on update restrict;

alter table ITEM_PROVEEDOR add constraint FK_ItemProveedor_Item foreign key
(ip_ItemID) references (it_ID) on delete restrict on update restrict;

alter table ITEM_PROVEEDOR add constraint FK_ItemProveedor_Proveedor foreign key
(ip_PrId) references (pr_ID) on delete restrict on update restrict;

alter table CARRITO_ITEM add constraint FK_CarritoItem_Item foreign key
(ci_ItemID) references (it_ID) on delete restrict on update restrict;

alter table CARRITO_ITEM add constraint FK_CarritoItem_Carrito foreign key
(ci_CarritoID) references (ca_ID) on delete restrict on update restrict;