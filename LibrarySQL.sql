CREATE DATABASE "Library"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE Publishers (
    PublisherID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Address TEXT,
    Email VARCHAR(255)
);

CREATE TABLE Authors (
    AuthorID SERIAL PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL
);

CREATE TABLE Genres (
    GenreID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE Books (
    BookID SERIAL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    PublicationYear INT CHECK (PublicationYear >= 0 AND PublicationYear <= EXTRACT(YEAR FROM CURRENT_DATE)),
    PublisherID INT,
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);

CREATE TABLE BookAuthors (
    BookID INT NOT NULL,
    AuthorID INT NOT NULL,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE BookGenres (
    BookID INT NOT NULL,
    GenreID INT NOT NULL,
    PRIMARY KEY (BookID, GenreID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

CREATE TABLE Users (
    PatronID SERIAL PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Address TEXT,
    PhoneNumber VARCHAR(20) CHECK (PhoneNumber ~ '^[0-9]{3}-[0-9]{3}-[0-9]{4}$'),
    MembershipDate DATE NOT NULL CHECK (MembershipDate <= CURRENT_DATE)
);

CREATE TABLE Staff (
    StaffID SERIAL PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL
);

CREATE TABLE BookCopies (
    CopyID SERIAL PRIMARY KEY,
    BookID INT NOT NULL,
    CopyNumber INT NOT NULL,
    Location VARCHAR(50),
    Status VARCHAR(20),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    CHECK (CopyID > 0 AND CopyNumber > 0)
);


CREATE TABLE BookLoans (
    LoanID SERIAL PRIMARY KEY,
    CopyID INT NOT NULL,
    PatronID INT NOT NULL,
    StaffID INT NOT NULL,
    LoanDate DATE NOT NULL CHECK (LoanDate <= CURRENT_DATE),
    ReturnDate DATE CHECK (ReturnDate >= LoanDate),
    FOREIGN KEY (CopyID) REFERENCES BookCopies(CopyID),
    FOREIGN KEY (PatronID) REFERENCES Users(PatronID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

CREATE TABLE BookReviews (
    ReviewID SERIAL PRIMARY KEY,
    BookID INT NOT NULL,
    PatronID INT NOT NULL,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    ReviewText TEXT,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (PatronID) REFERENCES Users(PatronID),
    UNIQUE (BookID, PatronID)
);
