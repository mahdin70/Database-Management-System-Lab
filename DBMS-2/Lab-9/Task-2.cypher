//(a) 

MATCH (b:Book)-[p:PURCHASED]->()
RETURN b.title, SUM(p.amount) AS total_revenue

//(b)

MATCH (g:Genre)<-[:BELONGS_TO]-(b:Book)-[r:RATED]->()
RETURN g.name, AVG(r.rating) AS average_rating

//(c)

MATCH (c:Customer)-[p:PURCHASED]->(b:Book)
WHERE c.name = 'N' AND p.purchasing_date >= '2022-01-01' AND p.purchasing_date <= '2022-12-31'
RETURN b.title

//(d)

MATCH (c:Customer)-[p:PURCHASED]->()
RETURN c.name, COUNT(p) AS total_purchases
ORDER BY total_purchases DESC
LIMIT 1

//(e)

MATCH (b:Book)-[p:PURCHASED]->()
RETURN b.title, COUNT(p) AS total_purchases
ORDER BY total_purchases DESC

//(f) 

MATCH (c:Customer)-[:PURCHASED|:RATED]->(b:Book {title: 'A'})
RETURN c.name

//(g) 

MATCH (c:Customer)-[:PURCHASED]->(b:Book)<-[:WROTE]-(a:Author {name: 'X'})
RETURN c.name

//(h) 

MATCH (b1:Book)<-[p1:PURCHASED]-(c:Customer)-[p2:PURCHASED]->(b2:Book)
WHERE b1 <> b2
WITH b1, b2, COUNT(DISTINCT c) AS num_customers
RETURN b1.title, b2.title, num_customers
ORDER BY num_customers DESC