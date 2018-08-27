create table INVENTORY (
    itemId varchar(255) not null,
    link varchar(255),
    location varchar(255),
    quantity int not null,
    primary key (itemId)
);

create table PRODUCT_CATALOG (
    itemId varchar(255) not null,
    description text,
    name varchar(255),
    price float not null,
    primary key (itemId)
);
