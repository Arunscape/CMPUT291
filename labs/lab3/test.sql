.echo on
-- More Exercises on Relational Algebra and SQL:

-- Consider the the following relation schemas as we saw before. Write each query in relational algebra and SQL.

-- product(maker,model,type);
-- pc(model,speed,ram,HD,price);
-- laptop(model,speed,ram,HD,price);
-- printer(model,color,type,price);

.print Which makers do have more than one model of printers?
SELECT maker FROM (
	SELECT maker, model FROM product
	JOIN printer USING(model)
	GROUP BY model
	HAVING COUNT(*) > 1
);

.print Which makers are producing PC of model 1003?
SELECT maker FROM product
JOIN pc USING(model)
WHERE model='1003'
;

.print  Which makers do have products that are priced over $1000?
SELECT DISTINCT maker FROM
product prod, pc, laptop, printer print
WHERE (prod.model = pc.model AND pc.price > 1000)
OR (prod.model = laptop.model AND laptop.price > 1000)
OR (prod.model = print.model AND print.price > 1000)
;

.print List the type and the model of products with a speed more than 200MHz.
SELECT type, model FROM
product JOIN pc USING(model)
WHERE speed > '200'
UNION
SELECT type, model FROM
product JOIN laptop USING(model)
WHERE speed > '200'
;
 
.print List printer models such that their makers dont make any other type of products.
SELECT model FROM (
	SELECT model, maker FROM product
	JOIN printer USING(model)
	EXCEPT
	SELECT model, maker FROM product
	JOIN pc USING(model)
	EXCEPT
	SELECT model, maker FROM product
	JOIN laptop USING(model)
);

.print Find PC models that are manufactured by the maker of a laptop model "2004".
SELECT model FROM product
JOIN pc USING(model)
WHERE maker IN (SELECT maker from product
		JOIN laptop USING(model)
		WHERE model='2004'
	);

.print  Find laptop models that are priced higher than all PCs.
SELECT DISTINCT model FROM product
JOIN laptop USING(model)
WHERE price > (SELECT MAX(pc.price) from pc);
