-- Delete the record with issued_id = 'IS121' from the issued_status table.

DELETE 
FROM issued_status
WHERE issued_id = "IS121"; 

-- Select all books issued by the employee with emp_id = 'E101'.

SELECT * 
FROM issued_status
WHERE issued_emp_id = 'E101';

-- List Members Who Have Issued More Than One Book

SELECT issued_member_id, count(*)
FROM issued_status
GROUP BY issued_member_id
HAVING count(*)>1 ;

-- Find Total Rental Income by Category

SELECT category, SUM(rental_price) AS Total_rental_income, COUNT(rental_price) AS Count
FROM books
GROUP BY category;

-- List Members Who Registered in the Last 2 years

SELECT * 
FROM members
WHERE reg_date >= CURRENT_DATE() - INTERVAL 2 YEAR;

-- List Employees with Their Branch Manager's Name and their branch details

SELECT employees.emp_id AS Id, employees.emp_name AS `Name`, employees.position AS Position, employees.salary AS Salary, branch.branch_address AS Address, e2.emp_name AS Manager_name
FROM employees
JOIN branch
 ON employees.branch_id = branch.branch_id
JOIN employees e2
 ON e2.emp_id = branch.manager_id;
 
-- Retrieve the List of Books Not Yet Returned

SELECT issued_status.issued_book_isbn, books.book_title, issued_status.issued_date, return_status.return_date
FROM issued_status
LEFT JOIN books
 ON books.isbn = issued_status.issued_book_isbn
LEFT JOIN return_status
 ON issued_status.issued_id = return_status.issued_id
WHERE return_status.return_date IS NULL;

-- Identify members who have overdue books and Display the member's_id, member's name, book title, issue date, and days overdue.

SELECT members.member_id AS Id, members.member_name AS Member_name, books.book_title, issued_status.issued_date, CURRENT_DATE() - issued_status.issued_date AS Overdue_Days
FROM issued_status
JOIN members
 ON members.member_id = issued_status.issued_member_id
JOIN books
 ON books.isbn = issued_status.issued_book_isbn
 LEFT JOIN return_status
  ON return_status.issued_id = issued_status.issued_id
WHERE return_status.return_date IS NULL 
AND CURRENT_DATE() - issued_status.issued_date > 730;

-- Write a query to find the top 5 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

SELECT employees.emp_name AS `Name`, 
issued_status.issued_emp_id AS Emp_id, 
COUNT(issued_status.issued_book_name) AS Total_Book_Issued, 
branch.branch_id AS Branch_Id,
branch.branch_address AS Address
FROM issued_status
JOIN employees
 ON employees.emp_id = issued_status.issued_emp_id
JOIN branch
 ON branch.branch_id = employees.branch_id
GROUP BY issued_status.issued_emp_id
ORDER BY 3 DESC
LIMIT 5;

-- Create a query to generate a performance report for each branch, showing the number of books issued, the number of books returned and the total revenue generated from book rentals.

SELECT branch.branch_id AS Branch_Id, branch.branch_address AS Address,
COUNT(issued_status.issued_id) AS Total_Issued,
COUNT(return_status.return_id) AS Return_Status,
SUM(books.rental_price) AS Total_Rental_Income
FROM issued_status
JOIN employees
 ON employees.emp_id = issued_status.issued_emp_id
JOIN branch
 ON branch.branch_id = employees.branch_id
LEFT JOIN return_status
 ON return_status.issued_id = issued_status.issued_id
JOIN books
 ON books.isbn = issued_status.issued_book_isbn
 GROUP BY branch_id, branch_address;

