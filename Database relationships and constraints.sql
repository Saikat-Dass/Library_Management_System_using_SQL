
-- Creating tables and inserting values by importing dataset and creating relationships between the tables

SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;

-- PRIMARY KEY AND FOREIGN KEY FOR 'books' TABLE

ALTER TABLE books
ADD PRIMARY KEY(isbn(255));

ALTER TABLE books
MODIFY isbn VARCHAR(50);

-- PRIMARY KEY AND FOREIGN KEY FOR 'branch' TABLE

ALTER TABLE branch
ADD PRIMARY KEY(branch_id(255));

ALTER TABLE branch
MODIFY branch_id VARCHAR(50);

-- PRIMARY KEY AND FOREIGN KEY FOR 'employees' TABLE

ALTER TABLE employees
ADD PRIMARY KEY(emp_id(50));

ALTER TABLE employees
MODIFY emp_id VARCHAR(50);

ALTER TABLE employees
MODIFY branch_id VARCHAR(50);

ALTER TABLE employees
ADD CONSTRAINT fk_branch FOREIGN KEY(branch_id)
REFERENCES branch(branch_id);

-- PRIMARY KEY AND FOREIGN KEY FOR 'issued_status' TABLE
ALTER TABLE issued_status
ADD PRIMARY KEY(issued_id(255));

ALTER TABLE issued_status
MODIFY issued_id VARCHAR(50);

ALTER TABLE issued_status
MODIFY issued_member_id VARCHAR(50);

ALTER TABLE issued_status
ADD CONSTRAINT fk_member FOREIGN KEY(issued_member_id)
REFERENCES members(member_id);

ALTER TABLE issued_status
MODIFY issued_book_isbn VARCHAR(50);

ALTER TABLE issued_status
ADD CONSTRAINT fk_book FOREIGN KEY(issued_book_isbn)
REFERENCES books(isbn);

ALTER TABLE issued_status
MODIFY issued_emp_id VARCHAR(50);

ALTER TABLE issued_status
ADD CONSTRAINT fk_emp FOREIGN KEY(issued_emp_id)
REFERENCES employees(emp_id);

-- PRIMARY KEY AND FOREIGN KEY FOR 'members' TABLE

ALTER TABLE members
ADD PRIMARY KEY(member_id(255));

ALTER TABLE members
MODIFY member_id VARCHAR(50);

-- PRIMARY KEY AND FOREIGN KEY FOR 'return_status' TABLE

ALTER TABLE return_status
ADD PRIMARY KEY(return_id(255));

ALTER TABLE return_status
MODIFY issued_id VARCHAR(50);

ALTER TABLE return_status
ADD CONSTRAINT fk_issue FOREIGN KEY(issued_id)
REFERENCES issued_status(issued_id);

ALTER TABLE return_status
MODIFY return_book_isbn VARCHAR(50);

ALTER TABLE return_status
ADD CONSTRAINT fk_books FOREIGN KEY(return_book_isbn)
REFERENCES books(isbn);

-- DELETING THE ROWS FROM return_status TO CONNECT TO issued_status
 
SELECT issued_id FROM return_status
WHERE issued_id NOT IN (SELECT issued_id FROM issued_status);

DELETE FROM return_status
WHERE issued_id NOT IN(SELECT issued_id FROM issued_status); 