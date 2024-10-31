# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# #################################################
# Users
# - admin      == 2_id      ==> admin@ahmed.com

#   ########

# - student    == 1_id      ==> admin@admin.com     at department == 1_id
# - student    == 5_id      ==> ahmed@ahmed.com     at department == 1_id
#
# - student    == 6_id      ==> khaled@khaled.com   at department == 2_id
# - student    == 7_id      ==> hema@hema.com       at department == 2_id
#
# - student    == 12_id     ==> std@std.com         at department == 3_id
# - student    == 13_id     ==> std1@std1.com       at department == 3_id

#   #########

# - instructor == 3_id      ==> inst@inst.com       at department == 1_id
# - instructor == 4_id      ==> inst1@inst.com      at department == 1_id
#
# - instructor == 8_id      ==> inst2@inst.com      at department == 2_id
# - instructor == 9_id      ==> inst3@inst.com      at department == 2_id
#
# - instructor == 10_id      ==> inst4@inst.com      at department == 3_id
# - instructor == 11_id      ==> inst5@inst.com      at department == 3_id

# ########

# Departments
# - 1\ Computer Science     == 1_id The Manager is id == 3
# - 2\ AI                   == 2_id The Manager is id == 9
# - 3\ science              == 3_id The Manager is id == 11

# ########

# Courses in department ==> 1_id
# - 1\ Math                 == 1_id     at department == 1_id     instructor == 3_id
# - 2\ computer science     == 2_id     at department == 1_id     instructor == 3_id

# # ########

# Courses in department ==> 2_id
# # - 1\ cr1                 == 3_id     at department == 2_id     instructor == 8_id
# # - 2\ cr2                 == 4_id     at department == 2_id     instructor == 8_id

# ########

# Courses in department ==> 3_id
# # - 1\ cr3                 == 5_id     at department == 3_id     instructor == 10_id
# # - 2\ cr4                 == 6_id     at department == 3_id     instructor == 10_id
# #################################################


# Create Department
# ########################
# department = Department.create!(
#   name: "Computer",
#   manager_id: 3,
#   description: "Description for computer science department"
# )
# #########################
# ai = Department.create!(
#   name: "AI",
#   description: "Description for computer science department"
# )
# # #########################
# science = Department.create!(
#   name: "science",
#   description: "Description for computer science department"
# )
# ###########################
# Create Course
# #########################
# course = Course.create!(
#   name: "cr3",
#   description: "cr is course.",
#   instructor_id: 10,
#   department_id: 3
# )
# ########################
# course1 = Course.create!(
#   name: "cr4",
#   description: "cr is course.",
#   instructor_id: 10,
#   department_id: 3
# )