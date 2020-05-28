set -e
psql -U postgres library << EOSQL
CREATE TABLE IF NOT EXISTS library(
    id SERIAL NOT NULL PRIMARY KEY,
    name varchar(256),
    address varchar(1000)
);

CREATE TABLE IF NOT EXISTS book_category(
    id SERIAL NOT NULL PRIMARY KEY,
    name varchar(256)
);

CREATE TABLE IF NOT EXISTS book(
    id SERIAL NOT NULL PRIMARY KEY,
    title varchar(256),
    category_id integer REFERENCES book_category (id),
    author_name varchar(256),
    isbn varchar(256),
    release_date timestamp,
    synopsis varchar(256)
);

CREATE TABLE IF NOT EXISTS book_stock(
    id SERIAL NOT NULL PRIMARY KEY,
	book_id integer REFERENCES book (id),
	library_id integer REFERENCES library (id),
    total integer
);

CREATE TABLE IF NOT EXISTS customer(
    id SERIAL NOT NULL,
    name varchar(256),
    password varchar(100),
    gender integer,
    age integer,
    favorite_book varchar(256),
    favorite_book_category integer,
    favorite_author varchar(256),
    FOREIGN KEY (favorite_book_category) REFERENCES book_category(id),
    PRIMARY KEY(id)
);
CREATE INDEX ON customer(id);
CREATE TABLE IF NOT EXISTS review(
    id  SERIAL NOT NULL PRIMARY KEY,
	book_id integer,
    customer_id integer,
    comment varchar(1000),
    rating integer,
	FOREIGN KEY (book_id) REFERENCES book(id),
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);
CREATE INDEX ON review(id);

INSERT INTO book_category (name) VALUES
    ('ミステリー'), 
    ('サスペンス'), 
    ('ヒューマン'), 
    ('アニメーション');

INSERT INTO library (name, address) VALUES
    ('豊洲図書館','豊洲'),
    ('品川図書館','品川'),
    ('駒場図書館','駒場');

INSERT INTO book (title, category_id, author_name, isbn, release_date, synopsis) VALUES
    ('映画001', 1, '俳優001', 'xxxxxx', cast('2017-01-01 00:00:00' as TIMESTAMP), '映画001概要'),
    ('映画002', 2, '俳優002', 'xxxxxx', cast('2017-02-01 00:00:00' as TIMESTAMP), '映画002概要'),
    ('映画003', 3, '俳優003', 'xxxxxx', cast('2017-03-01 00:00:00' as TIMESTAMP), '映画003概要'),
    ('映画004', 4, '俳優004', 'xxxxxx', cast('2017-04-01 00:00:00' as TIMESTAMP), '映画004概要'),
    ('映画005', 4, '俳優005', 'xxxxxx', cast('2017-05-01 00:00:00' as TIMESTAMP), '映画005概要');

INSERT INTO book_stock (book_id, library_id, total) VALUES
    (1, 1, 1),
    (2, 1, 2),
    (3, 1, 3),
    (4, 1, 4),
    (5, 1, 5),
    (4, 1, 6),
    (3, 1, 7),
    (2, 1, 8),
    (1, 1, 8),
    (1, 2, 1),
    (2, 2, 2),
    (3, 2, 3),
    (4, 2, 4),
    (5, 2, 5),
    (4, 2, 6),
    (3, 2, 7),
    (2, 2, 8),
    (1, 2, 8),
    (1, 3, 1),
    (2, 3, 2),
    (3, 3, 3),
    (4, 3, 4),
    (5, 3, 5),
    (4, 3, 6),
    (3, 3, 7),
    (2, 3, 8),
    (1, 3, 8);

INSERT INTO customer (name, password, gender, age, favorite_book, favorite_book_category, favorite_author) VALUES
    ('user001', 'pass001', 1, 35, '映画001', 1, '俳優001'),
    ('user002', 'pass002', 2, 22, '映画001', 2, '俳優002'),
    ('user003', 'pass003', 1, 18, '映画001', 3, '俳優003'),
    ('user004', 'pass004', 2, 25, '映画001', 2, '俳優004'),
    ('user005', 'pass005', 1, 31, '映画001', 4, '俳優002');
    
INSERT INTO review (book_id, customer_id, comment, rating) VALUES
    (1,1,'面白かったです！', 5),
    (2,2,'面白くない', 1),
    (3,3,'まぁまぁでした', 3),
    (4,4,'あまり面白くない', 2),
    (5,5,'わりとよかった！！', 4),
    (2,4,'おもしろかったー！！', 5),
    (3,1,'さいこーでした！！！', 5);
