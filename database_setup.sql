-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS courses_student_db;

-- Use the database
USE courses_student_db;

-- Create authors table
CREATE TABLE IF NOT EXISTS authors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50),
    birth_date DATE
);

-- Create books table
CREATE TABLE IF NOT EXISTS books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    genre VARCHAR(50),
    isbn VARCHAR(20) UNIQUE NOT NULL,
    published_year INT,
    author_id INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE CASCADE
);

-- Insert sample authors
INSERT INTO authors (name, nationality, birth_date) VALUES
('J.K. Rowling', 'British', '1965-07-31'),
('George R.R. Martin', 'American', '1948-09-20'),
('J.R.R. Tolkien', 'British', '1892-01-03'),
('Agatha Christie', 'British', '1890-09-15'),
('Stephen King', 'American', '1947-09-21'),
('Harper Lee', 'American', '1926-04-28'),
('F. Scott Fitzgerald', 'American', '1896-09-24'),
('Jane Austen', 'British', '1775-12-16'),
('Leo Tolstoy', 'Russian', '1828-09-09'),
('Gabriel García Márquez', 'Colombian', '1927-03-06');

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
('It', 'Horror', '9781501142970', 1986, 5);

-- Verify the data
SELECT 'Authors' AS 'Table', COUNT(*) AS 'Count' FROM authors
UNION
SELECT 'Books', COUNT(*) FROM books;

-- Show sample data
SELECT 'Sample Authors' AS 'Data';
SELECT * FROM authors;

SELECT 'Sample Books' AS 'Data';
SELECT b.id, b.title, a.name AS author, b.genre, b.isbn, b.published_year 
FROM books b
JOIN authors a ON b.author_id = a.id;
