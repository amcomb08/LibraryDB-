-------Select Where statements

--Find Books with a rating of 5
SELECT * 
FROM BookReviews 
WHERE Rating = 5;

--Find book loans by Name
SELECT * 
FROM BookLoans 
WHERE PatronID = (SELECT PatronID FROM Users WHERE FirstName = 'John' AND LastName = 'Doe');

--Get all books that are available
SELECT * 
FROM BookCopies 
WHERE Status = 'Available';

--Find users who joined on a certain date 
SELECT * 
FROM Users 
WHERE MembershipDate > '2022-01-01';

--Find books from specific Publisher
SELECT * 
FROM Books 
WHERE PublisherID = (SELECT PublisherID FROM Publishers WHERE Name = 'Boring Reads');

------Set Operations

--Get users who have written a review and borrowed a book
SELECT PatronID FROM BookLoans
INTERSECT
SELECT PatronID FROM BookReviews;

--Find books that have been loaned and reviewed
SELECT BookID FROM BookLoans
UNION
SELECT BookID FROM BookReviews;


------Group By/ Having

--Find Authors who have written more than 1 book
SELECT AuthorID, COUNT(BookID) 
FROM BookAuthors
GROUP BY AuthorID
HAVING COUNT(BookID) > 1;

--Get Average rating of book that have at least 2 ratings
SELECT BookID, AVG(Rating)
FROM BookReviews
GROUP BY BookID
HAVING COUNT(ReviewID) > 2;

-------Aggregation functions

--Find count of all books 
SELECT COUNT(*) AS TotalBooks
FROM Books;


--Find total number or copies for each book
SELECT SUM(BC.CopyNumber) AS TotalCopies
FROM BookCopies BC;


------Cartesian Product

--Authors and Books
SELECT A.*, B.*
FROM Authors A, Books B;

--Staff and Users 
SELECT S.*, U.*
FROM Staff S, Users U;


-------Using Sub-query

--Find all books that have never been loaned 
SELECT *
FROM Books
WHERE BookID NOT IN (
    SELECT BookID
    FROM BookCopies
    WHERE CopyID IN (
        SELECT CopyID
        FROM BookLoans
    )
);

--Find all books with the rating of 5 
SELECT *
FROM Books
WHERE BookID IN (
    SELECT BookID
    FROM BookReviews
    WHERE Rating = 5
);

------Using Inner-join

--Get all users along with the books they have reviewed
SELECT Users.FirstName, Users.LastName, Books.Title, BookReviews.Rating
FROM Users
INNER JOIN BookReviews ON Users.PatronID = BookReviews.PatronID
INNER JOIN Books ON BookReviews.BookID = Books.BookID;

--Get all book on loan along with user and staff details
SELECT Users.FirstName AS Patron_FirstName, Users.LastName AS Patron_LastName, Staff.FirstName AS Staff_FirstName, Staff.LastName AS Staff_LastName, Books.Title
FROM BookLoans
INNER JOIN Users ON BookLoans.PatronID = Users.PatronID
INNER JOIN Staff ON BookLoans.StaffID = Staff.StaffID
INNER JOIN BookCopies ON BookLoans.CopyID = BookCopies.CopyID
INNER JOIN Books ON BookCopies.BookID = Books.BookID;


------Left,Right,outer join

--Get all books and their respective reviews
SELECT Books.Title, BookReviews.Rating
FROM Books
LEFT JOIN BookReviews ON Books.BookID = BookReviews.BookID;

--Get all authors and their respective books
SELECT Authors.FirstName, Authors.LastName, Books.Title
FROM Authors
LEFT JOIN BookAuthors ON Authors.AuthorID = BookAuthors.AuthorID
LEFT JOIN Books ON BookAuthors.BookID = Books.BookID;


------Create views

--View all users and their current loans
CREATE VIEW UsersLoans AS
SELECT Users.FirstName, Users.LastName, Books.Title
FROM Users
JOIN BookLoans ON Users.PatronID = BookLoans.PatronID
JOIN BookCopies ON BookLoans.CopyID = BookCopies.CopyID
JOIN Books ON BookCopies.BookID = Books.BookID;

--Shows books and their genres 
CREATE VIEW BooksGenres AS
SELECT Books.Title, Genres.Name AS Genre
FROM Books
JOIN BookGenres ON Books.BookID = BookGenres.BookID
JOIN Genres ON BookGenres.GenreID = Genres.GenreID;


------Create role 
CREATE ROLE librarian;
CREATE USER user1 WITH PASSWORD 'password123';
CREATE USER user2 WITH PASSWORD 'password321';

--Grant the role to the users
GRANT librarian TO user1, user2;

--Give user1 essential privileges
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO user1;


------Functions

--Function to count all books in lib
CREATE FUNCTION total_books() RETURNS INTEGER AS $$
BEGIN
   RETURN (SELECT COUNT(*) FROM Books);
END;
$$ LANGUAGE plpgsql;

--Function to get books of a certain genre
CREATE FUNCTION get_genre_books(genre_id INT) RETURNS TABLE(BookID INT, Title VARCHAR(255), PublicationYear INT, PublisherID INT) AS $$
BEGIN
  RETURN QUERY 
    SELECT Books.BookID, Books.Title, Books.PublicationYear, Books.PublisherID 
    FROM Books 
    JOIN BookGenres ON Books.BookID = BookGenres.BookID 
    WHERE BookGenres.GenreID = genre_id;
END;
$$ LANGUAGE plpgsql;


------Procedures 
--Update review ratings
CREATE OR REPLACE PROCEDURE update_review_rating(p_reviewid INT, p_rating INT)
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE BookReviews SET Rating = p_rating WHERE ReviewID = p_reviewid;
END;
$$;

--Delete a book 
CREATE OR REPLACE PROCEDURE delete_book(p_bookid INT)
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM Books WHERE BookID = p_bookid;
END;
$$;


------Trigger 

--Update the status of a book each time it is loaned
CREATE OR REPLACE FUNCTION update_book_status() RETURNS TRIGGER AS $$
BEGIN
    UPDATE BookCopies SET Status = 'Loaned' WHERE CopyID = NEW.CopyID;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_book_status_trigger
AFTER INSERT ON BookLoans
FOR EACH ROW
EXECUTE FUNCTION update_book_status();









