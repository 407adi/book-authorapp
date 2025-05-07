# Bookstore Management System

A Spring Boot CRUD application for managing books and authors with MySQL database.

## Features

- Manage Authors (CRUD operations)
- Manage Books (CRUD operations)
- Search functionality
- Responsive UI with Bootstrap 5
- Form validation
- JSP views with JSTL

## Prerequisites

- Java 11 or higher
- Maven 3.6.3 or higher
- MySQL 8.0 or higher

## Setup

1. **Database Setup**
   - Create a MySQL database named `courses_student_db`
   - Update the database credentials in `src/main/resources/application.properties` if needed

2. **Build the Application**
   ```bash
   mvn clean install
   ```

3. **Run the Application**
   ```bash
   mvn spring-boot:run
   ```

4. **Access the Application**
   - Open your browser and go to: http://localhost:8080/bookstore/

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/
│   │       └── bookstore/
│   │           ├── config/         # Configuration classes
│   │           ├── controller/     # Web controllers
│   │           ├── model/          # Entity classes
│   │           ├── repository/     # Data access layer
│   │           ├── service/        # Business logic layer
│   │           └── BookstoreApplication.java
│   ├── resources/
│   │   └── application.properties
│   └── webapp/
│       └── WEB-INF/
│           └── views/             # JSP views
└── test/                          # Test classes
```

## API Endpoints

### Authors
- GET    /authors           - List all authors
- GET    /authors/add       - Show add author form
- POST   /authors/save      - Save author
- GET    /authors/edit/{id} - Show edit author form
- GET    /authors/delete/{id} - Delete author

### Books
- GET    /books           - List all books
- GET    /books/add       - Show add book form
- POST   /books/save      - Save book
- GET    /books/edit/{id} - Show edit book form
- GET    /books/delete/{id} - Delete book

## Technologies Used

- **Backend**: Spring Boot 2.7.0
- **Database**: MySQL 8.0
- **Frontend**: Bootstrap 5, JSP, JSTL
- **Build Tool**: Maven
- **Java Version**: 11

## License

This project is licensed under the MIT License.
