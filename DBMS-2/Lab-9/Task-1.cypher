//Genre nodes
CREATE (:Genre {name: 'Romance'})
CREATE (:Genre {name: 'Mystery'})
CREATE (:Genre {name: 'Science Fiction'})
CREATE (:Genre {name: 'Fantasy'})
CREATE (:Genre {name: 'Thriller'})
CREATE (:Genre {name: 'Biography'})

//Author nodes
CREATE (:Author {name: 'Agatha Christie', country: 'UK', date_of_birth: '15 September 1890'})
CREATE (:Author {name: 'J.K. Rowling', country: 'UK', date_of_birth: '31 July 1965'})
CREATE (:Author {name: 'George Orwell', country: 'UK', date_of_birth: '25 June 1903'})

//Book nodes
CREATE (:Book {title: 'Harry Potter and the Philosopher\'s Stone', published_year: 1997, language: 'English', page_count: 223, price: 10.99})
CREATE (:Book {title: '1984', published_year: 1949, language: 'English', page_count: 328, price: 8.99})
CREATE (:Book {title: 'Murder on the Orient Express', published_year: 1934, language: 'English', page_count: 347, price: 9.99})
CREATE (:Book {title: 'The Murder of Roger Ackroyd', published_year: 1926, language: 'English', page_count: 299, price: 7.99})
CREATE (:Book {title: 'Animal Farm', published_year: 1945, language: 'English', page_count: 112, price: 6.99})
CREATE (:Book {title: 'The Hobbit', published_year: 1937, language: 'English', page_count: 310, price: 12.99})
CREATE (:Book {title: 'Becoming', published_year: 2018, language: 'English', page_count: 448, price: 14.99})
CREATE (:Book {title: 'Sapiens: A Brief History of Humankind', published_year: 2011, language: 'English', page_count: 443, price: 11.99})

//Customer nodes
CREATE (:Customer {customer_id: 'C001', name: 'John Smith', phone_no: '555-1234', age: 30, gender: 'Male', country: 'USA'})
CREATE (:Customer {customer_id: 'C002', name: 'Jane Doe', phone_no: '555-5678', age: 25, gender: 'Female', country: 'Canada'})
CREATE (:Customer {customer_id: 'C003', name: 'Bob Williams', phone_no: '555-9012', age: 45, gender: 'Male', country: 'UK'})


//Relationship between customers and books
MATCH (c:Customer {customer_id: 'C001'}), (b:Book {title: 'Harry Potter and the Philosopher\'s Stone'})
CREATE (c)-[:PURCHASED {purchasing_date: '2022-01-01', amount: 10.99}]->(b)

MATCH (c:Customer {customer_id: 'C001'}), (b:Book {title: '1984'})
CREATE (c)-[:PURCHASED {purchasing_date: '2022-01-01', amount: 8.99}]->(b)

MATCH (c:Customer {customer_id: 'C002'}), (b:Book {title: 'Murder on the Orient Express'})
CREATE (c)-[:PURCHASED {purchasing_date: '2022-01-02', amount: 9.99}]->(b)

MATCH (c:Customer {customer_id: 'C002'}), (b:Book {title: 'The Murder of Roger Ackroyd'})
CREATE (c)-[:PURCHASED {purchasing_date: '2022-01-03', amount: 7.99}]->(b)

MATCH (c:Customer {customer_id: 'C003'}), (b:Book {title: 'Animal Farm'})
CREATE (c)-[:PURCHASED {purchasing_date: '2022-01-04', amount: 6.99}]->(b)

MATCH (c:Customer {customer_id: 'C003'}), (b:Book {title: 'The Hobbit'})
CREATE (c)-[:PURCHASED {purchasing_date: '2022-01-04', amount: 12.99}]->(b)


//Books and Genres
MATCH (b:Book {title: '1984'}), (g:Genre {name: 'Science Fiction'})
CREATE (b)-[:BELONGS_TO]->(g)

MATCH (b:Book {title: 'Murder on the Orient Express'}), (g:Genre {name: 'Mystery'})
CREATE (b)-[:BELONGS_TO]->(g)

MATCH (b:Book {title: 'The Murder of Roger Ackroyd'}), (g:Genre {name: 'Mystery'})
CREATE (b)-[:BELONGS_TO]->(g)

MATCH (b:Book {title: 'Animal Farm'}), (g:Genre {name: 'Politics'})
CREATE (b)-[:BELONGS_TO]->(g)

MATCH (b:Book {title: 'The Hobbit'}), (g:Genre {name: 'Fantasy'})
CREATE (b)-[:BELONGS_TO]->(g)

MATCH (b:Book {title: 'Becoming'}), (g:Genre {name: 'Biography'})
CREATE (b)-[:BELONGS_TO]->(g)

MATCH (b:Book {title: 'Sapiens: A Brief History of Humankind'}), (g:Genre {name: 'Science'})
CREATE (b)-[:BELONGS_TO]->(g)

//Books and authors
MATCH (b:Book {title: 'Murder on the Orient Express'}), (a:Author {name: 'Agatha Christie'})
CREATE (a)-[:WROTE {writing_year: 1934}]->(b)

MATCH (b:Book {title: 'The Murder of Roger Ackroyd'}), (a:Author {name: 'Agatha Christie'})
CREATE (a)-[:WROTE {writing_year: 1926}]->(b)

MATCH (b:Book {title: 'Animal Farm'}), (a:Author {name: 'George Orwell'})
CREATE (a)-[:WROTE {writing_year: 1945}]->(b)

MATCH (b:Book {title: '1984'}), (a:Author {name: 'George Orwell'})
CREATE (a)-[:WROTE {writing_year: 1949}]->(b)







