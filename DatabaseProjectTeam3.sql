CREATE DATABASE IF NOT EXISTS gradebook;

USE gradebook;

CREATE TABLE Students (
    STUD_ID INT NOT NULL,
    STUD_FNAME VARCHAR(255) NOT NULL,
    STUD_LNAME VARCHAR(255) NOT NULL,
    STUD_MAJOR VARCHAR(255) NOT NULL,
    PRIMARY KEY (STUD_ID)
);

CREATE TABLE Courses (
    COS_ID INT NOT NULL,
    COS_NAME VARCHAR(255) NOT NULL,
    COS_NUM INT NOT NULL,
    SEM_TERM VARCHAR(255) NOT NULL,
    YEAR INT NOT NULL,
    DEPT_NAME VARCHAR(255) NOT NULL,
    PRIMARY KEY (COS_ID)
);

CREATE TABLE Categories (
    CAT_ID INT NOT NULL auto_increment,
    CAT_NAME VARCHAR(255) NOT NULL,
    CAT_WEIGHT INT NOT NULL,
    COS_ID INT NOT NULL,
    PRIMARY KEY (CAT_ID),
    FOREIGN KEY (COS_ID)
        REFERENCES Courses (COS_ID)
);

CREATE TABLE Assignments (
    ASST_ID INT NOT NULL auto_increment,
    ASST_NAME VARCHAR(255) NOT NULL,
    ASST_TOTAL_PTS FLOAT NOT NULL,
    CAT_ID INT NOT NULL,
    PRIMARY KEY (ASST_ID),
    FOREIGN KEY (CAT_ID)
        REFERENCES Categories (CAT_ID)
);

CREATE TABLE Enrollment (
    COS_ID INT NOT NULL,
    STUD_ID INT NOT NULL,
    PRIMARY KEY (COS_ID , STUD_ID),
    FOREIGN KEY (COS_ID)
        REFERENCES Courses (COS_ID),
    FOREIGN KEY (STUD_ID)
        REFERENCES Students (STUD_ID)
);

CREATE TABLE Scores (
    STUD_ID INT NOT NULL,
    ASST_ID INT NOT NULL,
    COS_ID INT NOT NULL,
    STUD_PTS FLOAT NOT NULL,
    PRIMARY KEY (STUD_ID , ASST_ID , COS_ID),
    FOREIGN KEY (STUD_ID)
        REFERENCES Students (STUD_ID),
    FOREIGN KEY (ASST_ID)
        REFERENCES Assignments (ASST_ID),
    FOREIGN KEY (COS_ID)
        REFERENCES Courses (COS_ID)
);

INSERT INTO Students 
VALUES (001, 'Nicholas', 'Wayoe', 'Computer Science'),
(002, 'Jade', 'Calina', 'Computer Science'),
(003, 'Josh', 'Diaz', 'Chemical Engineering'),
(004, 'Amanda', 'Harris', 'Mechanical Engineering'),
(005, 'Mike', 'Qoung', 'Mechanical Engineering'),
(006, 'Bright', 'Buckmae', 'Mechanical Engineering');

INSERT INTO Courses
VAlUES (123, 'Database Systems', 45, 'Spring', 2023, 'Computer Science'),
(124, 'Intro to Computer Science', 46, 'Spring', 2023, 'Computer Science');

-- categories for cos 123
INSERT INTO Categories(CAT_NAME,CAT_WEIGHT, COS_ID)
VALUES ('Participation', 5,123),
('Homework', 20, 123),
('Test',50, 123),
('Quizzes',25, 123);

-- categories for COS 123
INSERT INTO Categories(CAT_NAME,CAT_WEIGHT, COS_ID)
VALUES ('Participation',10,124),
('Homework',25,124),
('Test',40,124),
('Quizzes',25,124);
    
-- Assignment for COS 123
INSERT INTO Assignments (ASST_NAME, ASST_TOTAL_PTS, CAT_ID)
VALUES('HWK1', 50, 2),
('HWK2', 50, 2),
('TEST1', 100, 3),
('TEST2', 100, 3),
('QUIZ1', 20, 4),
('QUIZ2', 20, 4),
('Semester Participation', 50, 1);

-- Assignment for COS 124
INSERT INTO Assignments (ASST_NAME, ASST_TOTAL_PTS, CAT_ID)
VALUES('HWK1', 50, 2),
('HWK2', 50, 2),
('TEST1', 100, 3),
('TEST2', 100, 3),
('QUIZ1', 40, 4),
('QUIZ2', 40, 4),
('Semester Participation', 30, 1);

-- Enrollment for COS 123
INSERT INTO Enrollment
VALUES(123, 001),
(123, 002),
(123, 003);

-- Enrollment  for COS 124
INSERT INTO Enrollment
VALUES(124, 004),
(124, 005),
(124, 006);

-- Scores for COS 123
INSERT INTO Scores
VALUES(001,1,123,45),
(001,2,123,50),
(001,3,123,90),
(001,4,123,95),
(001,5,123,20),
(001,6,123,20),
(001,7,123,45);

INSERT INTO Scores
VALUES
(002,1,123,40),
(002,2,123,40),
(002,3,123,85),
(002,4,123,90),
(002,5,123,20),
(002,6,123,20),
(002,7,123,45);

INSERT INTO Scores
VALUES
(003,1,123,25),
(003,2,123,30),
(003,3,123,70),
(003,4,123,80),
(003,5,123,15),
(003,6,123,15),
(003,7,123,50);

-- Scores for COS 124
INSERT INTO Scores
VALUES
(004,1,124,50),
(004,2,124,50),
(004,3,124,70),
(004,4,124,90),
(004,5,124,40),
(004,6,124,40),
(004,7,124,30);

INSERT INTO Scores
VALUES
(005,1,124,40),
(005,2,124,45),
(005,3,124,100),
(005,4,124,95),
(005,5,124,25),
(005,6,124,30),
(005,7,124,30);

INSERT INTO Scores
VALUES
(006,1,124,45),
(006,2,124,35),
(006,3,124,95),
(006,4,124,100),
(006,5,124,30),
(006,6,124,30),
(006,7,124,30);

-- Task 3: Show the tables with the contents that you have inserted
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Enrollment;
SELECT * FROM Categories;
SELECT * FROM Assignments;
SELECT * FROM Scores;

-- Task 4: Compute the average/highest/lowest score of an assignment
SELECT Assignments.ASST_ID, AVG(Scores.STUD_PTS), MAX(Scores.STUD_PTS), MIN(Scores.STUD_PTS)
FROM Assignments JOIN Scores ON Assignments.ASST_ID = Scores.ASST_ID
WHERE scores.COS_ID = 123 AND Assignments.ASST_ID = 2;

-- Task 5: List all of the students in a given course
SELECT s.STUD_ID, s.STUD_FNAME, s.STUD_LNAME, s.STUD_MAJOR 
FROM Students s JOIN Enrollment e ON s.STUD_ID = e.STUD_ID
WHERE e.COS_ID = 123;

-- Task 6: List all of the students in a course and all of their scores on every assignment
SELECT s.STUD_ID, s.STUD_FNAME, s.STUD_LNAME, s.STUD_MAJOR, sc.ASST_ID, sc.STUD_PTS 
FROM Students s INNER JOIN Enrollment e ON s.STUD_ID = e.STUD_ID
    INNER JOIN Scores sc ON
        sc.STUD_ID = e.STUD_ID
WHERE e.COS_ID = 123;

-- Task 7: Add an assignment to a course
INSERT INTO Assignments (ASST_NAME, ASST_TOTAL_PTS, CAT_ID)
VALUES('HWK3', 50, 2);

-- Show new Assignment table
SELECT * FROM Assignments;

-- Task 8: Change the percentages of the categories for a course;
UPDATE Categories 
SET 
    CAT_WEIGHT = CASE CAT_ID
        WHEN 1 THEN 10
        WHEN 2 THEN 20
        WHEN 3 THEN 50
        WHEN 4 THEN 20
        ELSE CAT_WEIGHT
    END
WHERE
    COS_ID = 123 AND CAT_ID IN (1 , 2, 3, 4);
    
    
-- Show new Category table
SELECT * FROM Categories c
WHERE c.COS_ID = 123;

-- Task 9: Add 2 points to the score of each student on an assignment;
UPDATE Scores 
SET 
    STUD_PTS = STUD_PTS + 2
WHERE
    COS_ID = 123 AND ASST_ID = 5;
    
-- Show new Scores Table for Assignment 6
SELECT COS_ID, ASST_ID, STUD_ID, STUD_PTS FROM Scores
WHERE COS_ID = 456 AND ASST_ID = 6;

-- Task 10: Add 2 points just to those students whose last name contains a ‘Q’;
UPDATE Scores sc
        INNER JOIN
    Students st ON sc.STUD_ID = st.STUD_ID 
SET 
    sc.STUD_PTS = sc.STUD_PTS + 2
WHERE
	COS_ID = 123 AND st.STUD_LNAME LIKE '%q%';
    
-- Show new Scores Table for STU_ID=4
SELECT 
    COS_ID, ASST_ID, STUD_ID, STUD_PTS
FROM
    Scores
WHERE
    COS_ID = 123 AND STUD_ID = 4;
    
-- Task 11: Compute the grade for a student;
SELECT 
    s.COS_ID,
    s.STUD_ID,
    SUM(((s.STUD_PTS / a.ASST_TOTAL_PTS) * 100) * (ca.CAT_WEIGHT)) / SUM(ca.CAT_WEIGHT) AS Final_Grade
FROM
    Scores s
        LEFT JOIN
    Assignments a ON s.ASST_ID = a.ASST_ID
        JOIN
    Categories ca ON ca.CAT_ID = a.CAT_ID
WHERE
    s.COS_ID = 123 AND STUD_ID = 001;


-- Task 12: Compute the grade for a student, where the lowest score for a given category is dropped.
-- Lowest Test score is dropped
SELECT 
    s.COS_ID,
    s.STUD_ID,
    SUM(((s.STUD_PTS / a.ASST_TOTAL_PTS) * 100) * (ca.CAT_WEIGHT)) / SUM(ca.CAT_WEIGHT) AS Dropped_Grade
FROM
    Scores s
        LEFT JOIN
    Assignments a ON s.ASST_ID = a.ASST_ID
        JOIN
    Categories ca ON ca.CAT_ID = a.CAT_ID
WHERE
    s.COS_ID = 123 AND STUD_ID = 001
        AND STUD_PTS NOT IN (SELECT 
            MIN(s.STUD_PTS)
        FROM
            Scores s
                LEFT JOIN
            Assignments a ON s.ASST_ID = a.ASST_ID
                JOIN
            Categories ca ON ca.CAT_ID = a.CAT_ID
        WHERE
            a.CAT_ID = 3 AND s.COS_ID = 123
                AND STUD_ID = 001);
                
