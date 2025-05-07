-- Insert sample authors
INSERT INTO authors (name, nationality, birth_date) VALUES
('J.K. Rowling', 'British', '1965-07-31'),
('George R.R. Martin', 'American', '1948-09-20'),
('J.R.R. Tolkien', 'British', '1892-01-03'),
('Agatha Christie', 'British', '1890-09-15'),
('Stephen King', 'American', '1947-09-21'),
('Ernest Hemingway', 'American', '1899-07-21'),
('Virginia Woolf', 'British', '1882-01-25'),
('Charles Dickens', 'British', '1812-02-07'),
('Mark Twain', 'American', '1835-11-30'),
('Oscar Wilde', 'Irish', '1854-10-16'),
('Franz Kafka', 'Czech', '1883-07-03'),
('Albert Camus', 'French', '1913-11-07'),
('Gabriel Garcia Marquez', 'Colombian', '1927-03-06'),
('Milan Kundera', 'Czech', '1929-04-01'),
('Isabel Allende', 'Chilean', '1942-08-02');

-- Insert sample books
INSERT INTO books (title, genre, isbn, published_year, author_id) VALUES
('Harry Potter and the Philosopher''s Stone', 'Fantasy', '9780747532743', 1997, 1),
('Harry Potter and the Chamber of Secrets', 'Fantasy', '9780747538493', 1998, 1),
('A Game of Thrones', 'Fantasy', '9780553103540', 1996, 2),
('A Clash of Kings', 'Fantasy', '9780553108033', 1998, 2),
('The Hobbit', 'Fantasy', '9780547928227', 1937, 3),
('The Lord of the Rings', 'Fantasy', '9780544003415', 1954, 3),
('Murder on the Orient Express', 'Mystery', '9780062073495', 1934, 4),
('The A.B.C. Murders', 'Mystery', '9780062073501', 1936, 4),
('The Shining', 'Horror', '9780307743657', 1977, 5),
('It', 'Horror', '9781501142970', 1986, 5),
('The Old Man and the Sea', 'Fiction', '9780684801223', 1952, 6),
('To the Lighthouse', 'Modernist', '9780156907392', 1927, 7),
('Great Expectations', 'Classic', '9780141439563', 1861, 8),
('The Adventures of Huckleberry Finn', 'Adventure', '9780142437179', 1884, 9),
('The Picture of Dorian Gray', 'Gothic', '9780141439570', 1890, 10),
('The Metamorphosis', 'Absurdist', '9780553213690', 1915, 11),
('The Stranger', 'Philosophical', '9780679720201', 1942, 12),
('One Hundred Years of Solitude', 'Magical Realism', '9780060883287', 1967, 13),
('The Unbearable Lightness of Being', 'Philosophical', '9780061148521', 1984, 14),
('The House of the Spirits', 'Magical Realism', '9780307387262', 1982, 15);

-- Insert sample borrowers
INSERT INTO borrowers (name, email, phone, address) VALUES
('John Smith', 'john.smith@email.com', '555-0101', '123 Main St, Anytown'),
('Emma Johnson', 'emma.j@email.com', '555-0102', '456 Oak Ave, Somewhere'),
('Michael Brown', 'm.brown@email.com', '555-0103', '789 Pine Rd, Nowhere'),
('Sarah Davis', 'sarah.d@email.com', '555-0104', '321 Elm St, Anywhere'),
('David Wilson', 'd.wilson@email.com', '555-0105', '654 Maple Dr, Somewhere'),
('Lisa Anderson', 'l.anderson@email.com', '555-0106', '987 Cedar Ln, Nowhere'),
('James Taylor', 'j.taylor@email.com', '555-0107', '147 Birch St, Anywhere'),
('Jennifer Martinez', 'j.martinez@email.com', '555-0108', '258 Spruce Ave, Somewhere'),
('Robert Garcia', 'r.garcia@email.com', '555-0109', '369 Willow Rd, Nowhere'),
('Patricia Robinson', 'p.robinson@email.com', '555-0110', '741 Ash Dr, Anywhere');

-- Insert book copies (10-30 copies per book)
INSERT INTO book_copies (book_id, copy_number, price, status)
SELECT 
    b.id,
    n.n,
    ROUND(RAND() * 20 + 10, 2), -- Random price between 10 and 30
    CASE WHEN RAND() < 0.7 THEN 'AVAILABLE' ELSE 'BORROWED' END -- 70% available, 30% borrowed
FROM books b
CROSS JOIN (
    SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
    UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
    UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15
    UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20
    UNION SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25
    UNION SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30
) n
WHERE n.n <= FLOOR(RAND() * 21 + 10); -- Random number of copies between 10 and 30

-- Insert borrowing records for borrowed copies
INSERT INTO borrowing_records (book_copy_id, borrower_id, borrow_date, due_date, return_date, status)
SELECT 
    bc.id,
    b.id,
    DATE_SUB(CURRENT_DATE, INTERVAL FLOOR(RAND() * 30) DAY), -- Random borrow date within last 30 days
    DATE_ADD(CURRENT_DATE, INTERVAL FLOOR(RAND() * 14) DAY), -- Random due date within next 14 days
    CASE WHEN RAND() < 0.5 THEN DATE_ADD(CURRENT_DATE, INTERVAL FLOOR(RAND() * 14) DAY) ELSE NULL END, -- 50% chance of being returned
    CASE WHEN RAND() < 0.5 THEN 'RETURNED' ELSE 'BORROWED' END -- 50% chance of being returned
FROM book_copies bc
CROSS JOIN borrowers b
WHERE bc.status = 'BORROWED'
AND RAND() < 0.3; -- Only create records for 30% of borrowed copies 