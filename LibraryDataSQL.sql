INSERT INTO Publishers (PublisherID, Name, Address, Email) 
VALUES (1, 'OpenAI Publishing', '3180 18th St, San Francisco', 'contact@openaipublishing.com'), 
       (2, 'Neuralink Press', '660 3rd St, San Francisco', 'info@neuralinkpress.com'),
       (3, 'Starlink Books', 'SpaceX HQ, Hawthorne, CA', 'hello@starlinkbooks.com'),
       (4, 'Boring Reads', 'SpaceX HQ, Hawthorne, CA', 'support@boringreads.com'),
       (5, 'Tesla Literature', '3500 Deer Creek Road, Palo Alto, CA', 'query@teslaliterature.com');

INSERT INTO Authors (AuthorID, FirstName, LastName)
VALUES (1, 'John', 'Doe'),
       (2, 'Jane', 'Doe'),
       (3, 'Robert', 'Smith'),
       (4, 'Emily', 'Johnson'),
       (5, 'Michael', 'Brown');

INSERT INTO Genres (GenreID, Name)
VALUES (1, 'Science Fiction'),
       (2, 'Biography'),
       (3, 'Business'),
       (4, 'Self Help'),
       (5, 'Technical');


INSERT INTO Books (BookID, Title, PublisherID, PublicationYear)
VALUES (1, 'AI in Open Source', 1, 2023),
       (2, 'Elon Musk: A Biography', 2, 2023),
       (3, 'The Future of AI', 3, 2023),
       (4, 'The Boring Company Story', 4, 2023),
       (5, 'Tesla: From 0 to 100', 5, 2023),
       (6, 'SpaceX: To the Stars', 2, 2023),
       (7, 'Amazon: The Everything Store', 1, 2023),
       (8, 'Google: The Search Revolution', 3, 2023),
       (9, 'AI and Ethics', 1, 2023),
       (10, 'OpenAI and GPT-4', 1, 2023);

INSERT INTO BookAuthors (BookID, AuthorID)
VALUES (1, 1),
       (2, 2),
       (3, 1),
       (4, 3),
       (5, 4),
       (6, 5),
       (7, 3),
       (8, 4),
       (9, 1),
       (10, 1);

INSERT INTO BookGenres (BookID, GenreID)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5),
       (6, 1),
       (7, 3),
       (8, 5),
       (9, 1),
       (10, 5);

-- Insert data into Patrons
INSERT INTO Patrons (PatronID, FirstName, LastName, Address, PhoneNumber, MembershipDate)
VALUES (1, 'Alice', 'Smith', '123 Main St', '123-456-7890', '2021-01-01'),
       (2, 'Bob', 'Johnson', '456 Oak Rd', '234-567-8901', '2021-02-01'),
       (3, 'Charlie', 'Williams', '789 Pine Dr', '345-678-9012', '2021-03-01'),
       (4, 'Dave', 'Miller', '321 Elm St', '456-789-0123', '2021-04-01'),
       (5, 'Eva', 'Davis', '654 Maple Ave', '567-890-1234', '2021-05-01');

-- Insert data into Staff
INSERT INTO Staff (StaffID, FirstName, LastName)
VALUES (1, 'David', 'Davis'),
       (2, 'Eva', 'Evans'),
       (3, 'Frank', 'Franklin'),
       (4, 'Grace', 'Griffin'),
       (5, 'Henry', 'Harrison');




INSERT INTO BookCopies (CopyID, BookID, CopyNumber, Location, Status)
VALUES 
       (1, 1, 1, 'Shelf A1', 'Available'),
       (2, 1, 2, 'Shelf A2', 'Available'),
       (3, 2, 1, 'Shelf B1', 'Borrowed'),
       (4, 2, 2, 'Shelf B2', 'Borrowed'),
       (5, 3, 1, 'Shelf C1', 'Available'),
       (6, 3, 2, 'Shelf C2', 'Available'),
       (7, 4, 1, 'Shelf D1', 'Borrowed'),
       (8, 4, 2, 'Shelf D2', 'Borrowed'),
       (9, 5, 1, 'Shelf E1', 'Available'),
       (10, 5, 2, 'Shelf E2', 'Available');


INSERT INTO BookLoans (LoanID, CopyID, PatronID, StaffID, LoanDate, ReturnDate)
VALUES 
       (1, 3, 1, 1, '2023-01-05', '2023-01-15'),
       (2, 4, 2, 2, '2023-01-10', '2023-01-20'),
       (3, 7, 3, 3, '2023-02-01', '2023-02-11'),
       (4, 8, 4, 4, '2023-02-05', '2023-02-15');

INSERT INTO BookReviews (ReviewID, BookID, PatronID, Rating, ReviewText)
VALUES 
       (1, 1, 1, 4, 'Great book!'),
       (2, 2, 2, 5, 'Amazing read, would recommend.'),
       (3, 3, 3, 3, 'Decent, but not my favorite.'),
       (4, 4, 4, 1, 'I did not enjoy this book.'),
       (5, 1, 4, 5, 'Fantastic! A must read!'),
       (6, 2, 3, 4, 'I really liked this book.'),
       (7, 4, 1, 2, 'Not to my taste, found it boring.');