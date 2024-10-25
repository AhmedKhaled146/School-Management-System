# School Management System

**A comprehensive School Management System built with Ruby on Rails. This system allows students, instructors, and administrators to manage various aspects of a school environment, including course enrollment, assignments, and grading. The app provides a robust and scalable backend to handle authentication, student and instructor roles, and department-specific operations.**

***

## ERD
![School Management System-ERD.png](Database%20-%20solutions/School%20Management%20System-ERD.png)
***
## Mapping
![School Management System-Mapping.png](Database%20-%20solutions/School%20Management%20System-Mapping.png)
**Key Features:**

- Student:

    - Register, log in, and manage profile.
    - Enroll in courses and view their grades.
    - View all courses and assignments.
    - Delete their account.


- Instructor:
    - Register, log in, and manage profile.
    - Teach multiple courses across different departments.
      -Create and assign assignments to students.
      -View students enrolled in their courses.
      -Assign grades to students in each course.


-  Admin:
    - Approve new student and instructor accounts.
    - Add, update, or remove courses and departments.
    - Manage enrollment of students in courses.


- Departments:

    - Each department has many students and instructors.
    - Courses belong to a specific department.


**Technologies Used:**

    - Ruby on Rails for the backend.
    - PostgreSQL for the database.
    - Devise for user authentication.
    - Pundit for authorization and role management.

**Planned Features:**

    - Assignment submissions by students.
    - Notifications for new assignments or grades.
    - Course scheduling and timetables.



***

**Sprint 1: Basic User Authentication & Setup**

Goal: Set up the foundation of the project with user authentication (Devise), including roles for students, instructors, and admins.

**Tasks:**

* Initialize the Rails project.
* Set up the database (PostgreSQL).
* Install and configure Devise for user authentication.
* Create models for:
    - Student
    - Instructor
    - Admin
* Create user roles and add basic sign-up/login/logout functionality.
* Set up basic pages for user dashboard after login (e.g., home page for students and instructors).
* Add RSpec or any preferred testing framework for writing tests.

**Deliverables:**
* User authentication for all roles.
* Basic dashboard after login.
* Database structure and basic models.
***
**Sprint 2: User Profile Management & Authorization**

Goal: Implement user profile management, including role-based access control using Pundit.

**Tasks:**
* Implement Pundit for authorization to differentiate between:
    - Admin
    - Student
    - Instructor


* Create user profile pages:
    - Students: Profile page to update info.
    - Instructors: Profile page to update info.
    - Admin: Manage approval for new students and instructors.


* Implement edit and delete functionalities for students and instructors to manage their own profiles.
* Admin can approve student and instructor accounts.


**Deliverables:**
* Profile management for all user roles.
* Authorization (only admins can approve accounts).
* Students and instructors can edit and delete their accounts.
***
**Sprint 3: Course and Enrollment Management**

Goal: Implement the core functionality for managing courses, departments, and student enrollments.

**Tasks:**

* Create models for Department and Course.
* Admin can create and manage departments and courses.
* Create associations:
    - Departments have many students and instructors.
    - Courses belong to departments.
    - Students can enroll in courses.
* Create **EnrollmentsController** to allow students to enroll in courses.
* Admin can assign **Instructors** to courses.
* **StudentsController**: Students can view courses and enroll.
* Add validations and error handling (e.g., student can’t enroll in the same course twice).


**Deliverables:**

- Admin manages departments and courses.
- Students can view and enroll in courses.
- Basic validations for enrollments.
***
**Sprint 4: Assignments and Grading System**

Goal: Allow instructors to create assignments, and students can view them. Implement grading for student performance.

**Tasks:**
* Create Assignment and Grade models.
* **AssignmentsController:**
    - Instructors can create and manage assignments for courses they teach.
    - Students can view assignments for courses they are enrolled in.


* **GradesController:**
    - Instructors can assign grades to students in their courses.
    - Students can view their grades for courses.
* Add validation and error handling (e.g., students can’t view grades until assigned).

**Deliverables:**
- Instructors can create assignments for their courses.
- Instructors can assign grades to students.
- Students can view their assignments and grades.
***
**Sprint 5: Final Touches and Testing**

Goal: Polish the project, add final features, and ensure everything is tested and ready for deployment.

**Tasks:**
* Complete unit and integration tests for all major features (e.g., enrollments, assignments, grades).
* Add error handling, flash messages, and form validations across the app.
* Implement basic notifications (optional) for students (e.g., when a grade is assigned or a new assignment is added).
* Set up deployment to Heroku or another hosting platform.
* Conduct user acceptance testing to ensure all functionality is working as expected.
* Documentation: Update your README file with instructions, add API documentation if needed.

**Deliverables:**
* Fully tested system.
* Basic notifications (optional).
* Deployed app with full documentation.


**Post-Sprint Optional Features:**

- Assignment Submissions: Allow students to submit assignments.
- Course Schedule: Add a timetable for courses.
- Enhanced Notifications: Email notifications for important updates (new courses, grades, etc.).
