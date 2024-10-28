# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create Department
# ########################
# department = Department.create!(
#   name: "Computer",
#   manager_id: 3,
#   description: "Description for computer science department"
# )
# Create Course
# #########################
# course = Course.create!(
#   name: "math",
#   description: "math is course.",
#   instructor_id: 3,
#   department_id: 1
# )
# ########################
# course1 = Course.create!(
#   name: "Computer Science",
#   description: "computer science is course.",
#   instructor_id: 3,
#   department_id: 1
# )