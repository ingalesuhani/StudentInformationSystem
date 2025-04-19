INSERT INTO Teacher (first_name, last_name, email) VALUES
('Sarah', 'Smith', 'sarah.smith@example.com'),
('David', 'Jones', 'david.jones@example.com');

INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number) VALUES
('John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890'),
('Jane', 'Johnson', '1996-05-20', 'jane.johnson@example.com', '0987654321');

-- More inserts for Courses, Enrollments, Payments

INSERT INTO Courses (course_name, credits, teacher_id) VALUES
('Introduction to Programming', 3, 1),
('Mathematics 101', 4, 2),
('Computer Science 101', 3, 1),
('Advanced Database Management', 4, 1),
('Physics Basics', 3, 2);

INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2023-01-10'),
(1, 2, '2023-01-12'),
(2, 3, '2023-01-15'),
(2, 4, '2023-01-18'),
(2, 5, '2023-01-20');

INSERT INTO Payments (student_id, amount, payment_date) VALUES
(1, 250.00, '2023-02-01'),
(1, 150.00, '2023-03-01'),
(2, 300.00, '2023-02-10'),
(2, 200.00, '2023-03-05'),
(2, 500.00, '2023-04-10');

