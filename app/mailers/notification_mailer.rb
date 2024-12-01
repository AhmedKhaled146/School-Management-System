class NotificationMailer < ApplicationMailer
  def enrollment_notification(instructor, course, student)
    @instructor = instructor
    @course = course
    @student = student
    mail(to: @instructor.email, subject: "New Enrollment in Your Course")
  end
end
