# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Create an admin user
admin = User.create!(
  name: 'Admin User',
  email: 'admin@admin.com',
  password: '123456',
  password_confirmation: '123456',
  role: 'admin'
)

# Create a department without a manager first (manager_id is allowed to be nil now)
department = Department.create!(
  name: 'Computer Science',
  hire_date: Date.today,
  manager_id: nil
)

# Create a regular instructor user
instructor_user = User.create!(
  name: 'Instructor User',
  email: 'instructor@instructor.com',
  password: '123456',
  password_confirmation: '123456',
  role: 'instructor'
)

# Now create the instructor and assign the department_id
instructor = Instructor.create!(
  name: "Ahmed Instructor",
  email: "ahmed@instructor.com",
  phone: '1234567890',
  salary: 5000,
  user_id: instructor_user.id,
  department_id: department.id  # Assign department right away
)

# Finally, update the department to assign the manager (which is the instructor)
department.update!(manager_id: instructor.id)
