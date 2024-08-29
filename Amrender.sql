USE test;
-- Welcome to the world of MySQL

CREATE TABLE Students(
   student_id INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(50) NOT NULL,
   date_of_birth DATE NOT NULL,
   email VARCHAR(100) UNIQUE NOT NULL,
   phone_number VARCHAR(10)
);

CREATE TABLE StudentMarks(
   mark_id INT AUTO_INCREMENT PRIMARY KEY,
   student_id INT NOT NULL,
   subject VARCHAR(100) NOT NULL,
   marks INT NOT NULL,
   FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO Students (name, date_of_birth, email, phone_number)
VALUES
   ('Ravi Kumar', '2002-08-15', 'ravi.kumar@example.com', '9876543210'),
   ('Priya Sharma', '2001-12-05', 'priya.sharma@example.com', '8765432109'),
   ('Ankit Singh', '2000-04-25', 'ankit.singh@example.com', '7654321098'),
   ('Neha Gupta', '2002-11-20', 'neha.gupta@example.com', '6543210987'),
   ('Amit Verma', '2003-03-11', 'amit.verma@example.com', '5432109876');


INSERT INTO StudentMarks (student_id, subject, marks)
VALUES
    (1,'Hindi',87),
    (4,'Hindi',58),
    (5,'Hindi',91),

   (1, 'Mathematics', 45),
   (1, 'Science', 82),
   
   (2, 'Mathematics', 90),
   (2, 'Science', 42),
   (2, 'English', 71),
   
   
  
   (3, 'Mathematics', 55),
   (3, 'Science', 95),
   (3, 'English', 83),
   
   (4, 'Science', 58),
   (4, 'Mathematics', 65),
   
   (5, 'Science', 68),
   (5, 'Mathematics', 75);

ALTER TABLE Students
ADD COLUMN state VARCHAR(50) NOT NULL;

UPDATE Students
SET state = 'Uttar Pradesh'
WHERE student_id = 1;

UPDATE Students
SET state = 'Chennai'
WHERE student_id = 1;

UPDATE Students
SET state = 'Maharashtra'
WHERE student_id = 2;

UPDATE Students
SET state = 'Rajasthan'
WHERE student_id = 3;

UPDATE Students
SET state = 'Delhi'
WHERE student_id = 4;

UPDATE Students
SET state = 'Madhya Pradesh'
WHERE student_id = 5;


-- Find Students state-wise
SELECT name,state FROM students;

-- Find Students with the Subject English
SELECT s.student_id,s.name FROM students s
LEFT JOIN
studentmarks st
ON s.student_id = st.student_id
WHERE st.subject = 'English';

-- Group Student By Average Marks
SELECT student_id,
CASE
 WHEN AVG(marks) >= 85 THEN '85-100'
 WHEN AVG(marks) >= 60 THEN '60-85'
 WHEN AVG (marks) >= 40 THEN '40-60'
 ELSE '<40'
END AS grade 
FROM studentmarks
GROUP BY student_id;




-- Paper Wise Marks
SELECT 
    s.student_id,
    s.name,
    MAX(CASE WHEN st.subject = 'English' THEN st.marks ELSE NULL END) AS English,
    MAX(CASE WHEN st.subject = 'Mathematics' THEN st.marks ELSE NULL END) AS Mathematics,
    MAX(CASE WHEN st.subject = 'Science' THEN st.marks ELSE NULL END) AS Science,
    MAX(CASE WHEN st.subject = 'Hindi' THEN st.marks ELSE NULL END) AS Hindi
FROM 
    students s
LEFT JOIN 
    studentmarks st ON s.student_id = st.student_id
GROUP BY 
    s.student_id, s.name;


-- Total Marks vs Marks Obtained Percentage
SELECT s.student_id,s.name,SUM(st.marks) as total_marks,AVG(st.marks) as percentage
FROM students s
INNER JOIN studentmarks st
ON s.student_id = st.student_id
GROUP BY s.student_id,s.name;

-- Altering students table and adding category field
ALTER TABLE Students
ADD COLUMN category VARCHAR(20) NOT NULL;


-- updating the category of each children
UPDATE Students
SET category = 'General'
WHERE student_id = 1;

UPDATE Students
SET category = 'SC'
WHERE student_id = 2;

UPDATE Students
SET category = 'ST'
WHERE student_id = 3;

UPDATE Students
SET category = 'General'
WHERE student_id = 4;

UPDATE Students
SET category = 'SC'
WHERE student_id = 5;

-- Category Wise Marks
SELECT 
    s.category,
    st.subject,
    SUM(st.marks) AS total_marks
FROM 
    Students s
INNER JOIN 
    StudentMarks st ON s.student_id = st.student_id
GROUP BY 
    s.category, st.subject
ORDER BY 
    s.category, st.subject;


-- Subject Wise Topper. .i.e English, Maths
SELECT s.student_id,s.name,st.subject,MAX(st.marks) as maximum_marks FROM students s
INNER JOIN studentmarks st
ON s.student_id = st.student_id
GROUP BY st.subject; 

-- Copy of the data
CREATE TABLE studentmarks_copy AS 
SELECT * FROM studentmarks;

-- Delete operation
DELETE FROM studentmarks_copy 
WHERE marks < 50;


-- Truncate operation
TRUNCATE TABLE studentmarks_copy;

-- Drop operation
DROP TABLE studentmarks_copy;










   