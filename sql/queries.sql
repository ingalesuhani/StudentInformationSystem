Task 2 – DML & Conditions

-- Insert a new student
INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number)
VALUES ('John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');

-- Enroll student in a course
INSERT INTO Enrollments (student_id, course_id, enrollment_date)
VALUES (1, 2, '2023-04-10');

-- Update teacher email
UPDATE Teacher
SET email = 'new.email@example.com'
WHERE teacher_id = 1;

-- Delete specific enrollment
DELETE FROM Enrollments
WHERE student_id = 1 AND course_id = 2;

-- Assign a teacher to a course
UPDATE Courses
SET teacher_id = 2
WHERE course_id = 4;

-- Delete a student and their enrollments
DELETE FROM Enrollments WHERE student_id = 1;
DELETE FROM Students WHERE student_id = 1;

-- Update payment amount
UPDATE Payments
SET amount = 600.00
WHERE payment_id = 1;

Task 3 – Aggregates, GROUP BY, JOINs

-- Total payments made by a specific student
SELECT s.first_name, s.last_name, SUM(p.amount) AS total_paid
FROM Payments p
JOIN Students s ON p.student_id = s.student_id
WHERE s.student_id = 1
GROUP BY s.student_id;

-- Count of students per course
SELECT c.course_name, COUNT(e.student_id) AS student_count
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- Students not enrolled in any course
SELECT s.first_name, s.last_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

-- Students and the courses they are enrolled in
SELECT s.first_name, s.last_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- Teachers and their assigned courses
SELECT t.first_name, t.last_name, c.course_name
FROM Teacher t
LEFT JOIN Courses c ON t.teacher_id = c.teacher_id;

-- Students and their enrollment dates for a specific course
SELECT s.first_name, s.last_name, e.enrollment_date
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Mathematics 101';

-- Students who have not made any payments
SELECT s.first_name, s.last_name
FROM Students s
LEFT JOIN Payments p ON s.student_id = p.student_id
WHERE p.payment_id IS NULL;

-- Courses with no enrollments
SELECT c.course_name
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;

-- Students enrolled in more than one course
SELECT s.student_id, s.first_name, s.last_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id
HAVING COUNT(e.course_id) > 1;

-- Teachers not assigned to any course
SELECT t.first_name, t.last_name
FROM Teacher t
LEFT JOIN Courses c ON t.teacher_id = c.teacher_id
WHERE c.course_id IS NULL;


 Task 4 – Subqueries

-- Average number of students per course
SELECT AVG(student_count) AS avg_enrollment
FROM (
  SELECT COUNT(*) AS student_count
  FROM Enrollments
  GROUP BY course_id
) AS counts;

-- Student(s) with the highest payment
SELECT s.first_name, s.last_name, p.amount
FROM Payments p
JOIN Students s ON s.student_id = p.student_id
WHERE p.amount = (SELECT MAX(amount) FROM Payments);

-- Courses with highest number of enrollments
SELECT c.course_name, COUNT(e.student_id) AS total
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
HAVING COUNT(e.student_id) = (
  SELECT MAX(enroll_count) FROM (
    SELECT COUNT(student_id) AS enroll_count
    FROM Enrollments
    GROUP BY course_id
  ) AS sub
);

-- Total payments per teacher’s courses
SELECT t.first_name, t.last_name, SUM(p.amount) AS total_payments
FROM Teacher t
JOIN Courses c ON t.teacher_id = c.teacher_id
JOIN Enrollments e ON c.course_id = e.course_id
JOIN Payments p ON e.student_id = p.student_id
GROUP BY t.teacher_id;

-- Students enrolled in all available courses
SELECT s.student_id, s.first_name, s.last_name
FROM Students s
WHERE NOT EXISTS (
  SELECT course_id FROM Courses
  EXCEPT
  SELECT e.course_id FROM Enrollments e WHERE e.student_id = s.student_id
);

-- Teachers with no assigned courses
SELECT t.first_name, t.last_name
FROM Teacher t
WHERE NOT EXISTS (
  SELECT 1 FROM Courses c WHERE c.teacher_id = t.teacher_id
);

-- Average age of all students
SELECT AVG(TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())) AS average_age
FROM Students;

-- Courses with no enrollments (subquery version)
SELECT course_name FROM Courses
WHERE course_id NOT IN (SELECT course_id FROM Enrollments);

-- Total payments by student per course
SELECT s.student_id, s.first_name, c.course_name, SUM(p.amount) AS total_paid
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON c.course_id = e.course_id
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id, c.course_id;

-- Students who made more than one payment
SELECT s.first_name, s.last_name
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id
HAVING COUNT(p.payment_id) > 1;

-- Total payments made by each student
SELECT s.student_id, s.first_name, SUM(p.amount) AS total
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id;

-- Course names with student counts
SELECT c.course_name, COUNT(e.student_id) AS student_count
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- Average payment amount made by students
SELECT s.student_id, s.first_name, AVG(p.amount) AS avg_payment
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id;


 
