CREATE DATABASE Automotriz
GO

USE Automotriz
GO

CREATE TABLE AutoPlan (
    id_autoplan  int identity (1,1)  NOT NULL,
    cant_cuotas int  NOT NULL,
    Importe_Cuota money NULL,
    interes decimal (4,3)  NOT NULL,
    fecha datetime  NOT NULL,
    CONSTRAINT AutoPlan_pk PRIMARY KEY  (id_autoplan)
	)


CREATE TABLE Autopartes (
    id_Autoparte  int identity (1,1) NOT NULL,
    nombre varchar (50)  NOT NULL,
    tipoA varchar (80)  NOT NULL,
    precio money  NOT NULL,
    stock_minimo int  NOT NULL,
    stock_actual int  NOT NULL,
    CONSTRAINT Autopartes_pk PRIMARY KEY  (id_Autoparte)
	)

CREATE TABLE Formas_Pago (
    id_forma_pago int identity (1,1) NOT NULL,
    forma_pago varchar (80) NOT NULL,
    CONSTRAINT Formas_Pago_pk PRIMARY KEY  (id_forma_pago)
	)

CREATE TABLE Formas_envio (
    id_forma_envio int identity (1,1) NOT NULL,
    forma_envio varchar (80) NOT NULL,
    CONSTRAINT pk_Formas_envio PRIMARY KEY  (id_forma_envio)
	)

CREATE TABLE Tipos_Clientes(
    id_tipo_cliente int identity (1,1) NOT NULL,
    tipo_cliente varchar (50) NOT NULL,
    CONSTRAINT Tipos_Clientes_pk PRIMARY KEY  (id_tipo_cliente)
)

CREATE TABLE Provincias (
    Id_provincia int identity (1,1) NOT NULL,
    provincia varchar(80)  NOT NULL,
    CONSTRAINT Provincias_pk PRIMARY KEY  (Id_provincia)
)

CREATE TABLE Tipos_Vehiculos (
    id_tipoV int identity (1,1) NOT NULL,
    nombre_tipo varchar (50) NOT NULL,
    CONSTRAINT Tipos_Vehiculos_pk PRIMARY KEY (id_tipoV)
);

-- Creación de la tabla Vehiculos_Terminados
CREATE TABLE Vehiculos_Terminados (
    id_vehiculo int identity (1,1) NOT NULL,
    nombre varchar (50) NOT NULL,
    color varchar (50) NOT NULL,
    tipoV_id int NOT NULL, -- Cambio a tipoV_id para referenciar la nueva tabla de tipos de vehículos
    precio money NOT NULL,
    CONSTRAINT Vehiculos_Terminados_pk PRIMARY KEY (id_vehiculo),
    CONSTRAINT fk_vehiculos_tipoV FOREIGN KEY (tipoV_id) REFERENCES Tipos_Vehiculos(id_tipoV) -- Clave foránea hacia Tipos_Vehiculos
);


CREATE TABLE Localidades (
    Id_localidad int identity (1,1) NOT NULL,
    localidad varchar(80)  NOT NULL,
    Id_Provincia int  NOT NULL,
    CONSTRAINT Localidades_pk PRIMARY KEY  (Id_localidad),
	CONSTRAINT Localidades_provincias_fk FOREIGN KEY (Id_Provincia) references provincias (id_provincia)
)

CREATE TABLE Barrios (
    id_barrio int identity (1,1)  NOT NULL,
    nombreBarrio varchar(80)  NOT NULL,
    id_Localidad int  NOT NULL,
    CONSTRAINT Barrios_pk PRIMARY KEY  (id_barrio),
	CONSTRAINT fk_barrios_localidades FOREIGN KEY (id_localidad) references localidades (id_localidad)
)

CREATE TABLE Clientes (
    Id_cliente int identity (1,1) NOT NULL,
    ape_cliente varchar (50) NOT NULL,
    nom_cliente varchar (50) NOT NULL,
    id_Tipo_Cliente int  NOT NULL,
    nro_tel bigint  NOT NULL,
    mail varchar (80)  NULL,
    calle varchar (80) NOT NULL,
    altura int  NOT NULL,
    id_barrio int   NULL,
	fecha_nac datetime NULL,
    CONSTRAINT Clientes_pk PRIMARY KEY  (Id_cliente),
	CONSTRAINT fk_clientes_barrios FOREIGN KEY (id_barrio) references barrios (id_barrio),
	CONSTRAINT fk_clientes_tipo_cliente FOREIGN KEY (id_tipo_cliente) references tipos_clientes (id_tipo_cliente)
)

CREATE TABLE Vendedores (
    Id_vendedor int identity (1,1) NOT NULL,
    nom_vendedor varchar (80) NOT NULL,
    ape_vendedor varchar (80) NOT NULL,
    calle varchar (80) NOT NULL,
    altura int  NOT NULL,
    id_barrio int  NOT NULL,
    mail varchar (80) NULL,
    nro_tel bigint  NOT NULL,
	fecha_nac datetime NULL,
    CONSTRAINT Vendedores_pk PRIMARY KEY  (Id_vendedor),
	CONSTRAINT fk_vendedores_barrios FOREIGN KEY (id_barrio) references barrios (id_barrio)
)



CREATE TABLE Orden_Pedido (
    nro_orden int identity (1,1) NOT NULL,
    fecha_entrega smalldatetime  NOT NULL,
    detalle varchar (80)  NULL,
    cantidad int  NOT NULL,
    id_Autoparte int  NULL,
    id_Vehiculo int   NULL,
    id_cliente int  NOT NULL,
    CONSTRAINT Orden_Pedido_pk PRIMARY KEY  (nro_orden),
	CONSTRAINT fk_oren_pedido_autoparte FOREIGN KEY (id_autoparte) references autopartes (id_autoparte),
	CONSTRAINT fk_oren_pedido_vehiculo FOREIGN KEY (id_vehiculo) references vehiculos_terminados (id_vehiculo),
	CONSTRAINT fk_oren_pedido_cliente FOREIGN KEY (id_cliente) references clientes (id_cliente)	
)

CREATE TABLE Facturas (
    nroFac int identity (1,1) NOT NULL,
    fecha smalldatetime  NOT NULL,
    id_forma_pago int  NOT NULL,
	id_forma_envio int NOT NULL,
    id_cliente int  NOT NULL,
    nro_orden int  NOT NULL,
    Id_vendedor int  NOT NULL,
    CONSTRAINT Facturas_pk PRIMARY KEY  (nroFac),
	CONSTRAINT fk_facturas_clientes FOREIGN KEY (id_cliente) references clientes (id_cliente),
	CONSTRAINT fk_id_forma_envio FOREIGN KEY (id_forma_envio) references Formas_envio (id_forma_envio),
	CONSTRAINT fk_facturas_oden FOREIGN KEY (nro_orden) references orden_pedido (nro_orden),
	CONSTRAINT fk_facturas_vendedores FOREIGN KEY (id_vendedor) references vendedores (id_vendedor),
	CONSTRAINT fk_facturas_forma_pago FOREIGN KEY (id_forma_pago) references formas_pago (id_forma_pago)
)


CREATE TABLE Precios_Historicos (
    Id_Precio_hist int identity (1,1)  NOT NULL,
    id_vehiculo int  NULL,
    id_autoparte int  NULL,
    fecha_precio datetime  NOT NULL,
    precio_hist money  NOT NULL,
    CONSTRAINT Precios_Historicos_pk PRIMARY KEY  (Id_Precio_hist),
	CONSTRAINT fk_precios_hist_vehiculos FOREIGN KEY (id_vehiculo) references vehiculos_terminados (id_vehiculo),
	CONSTRAINT fk_precios_hist_autopartes FOREIGN KEY (id_autoparte) references autopartes (id_autoparte),
)

CREATE TABLE DetalleFactura (
    id_detalle int identity (1,1) NOT NULL,
    nroFac int  NOT NULL,
    id_autoplan int  NULL,
    precio_venta money  NOT NULL,
    cantidad int  NOT NULL,
    descuento int  NULL,
    id_autoparte int NULL,
    CONSTRAINT DetalleFactura_pk PRIMARY KEY  (id_detalle),
	CONSTRAINT fk_detalle_autopartes FOREIGN KEY (id_autoparte) references autopartes (id_autoparte),
	CONSTRAINT fk_detalle_auto_plan FOREIGN KEY (id_autoplan) references autoPlan (id_autoplan),
	CONSTRAINT fk_detalle_facturas FOREIGN KEY (nrofac) references facturas (nrofac)
)

CREATE TABLE Tipos_contactos (
	id_tipo_contacto int identity(1,1) not null,
	descripcion varchar(80) not null
	CONSTRAINT pk_id_tipo_contacto PRIMARY KEY(id_tipo_contacto)
)

CREATE TABLE Contactos (
	id_contacto int identity(1,1),
	contacto varchar(50) null,
	id_cliente int null,
	id_vendedor int null, 
	id_tipo_contacto int null,
	CONSTRAINT pk_id_contacto PRIMARY KEY  (id_contacto),
	CONSTRAINT fk_id_cliente FOREIGN KEY (id_cliente) references clientes (id_cliente),
	CONSTRAINT fk_id_vendedor FOREIGN KEY (id_vendedor) references vendedores (id_vendedor),
	CONSTRAINT fk_id_tipo_contacto FOREIGN KEY (id_tipo_contacto) references tipos_contactos (id_tipo_contacto)
);



