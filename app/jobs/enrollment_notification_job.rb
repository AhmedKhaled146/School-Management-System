class EnrollmentNotificationJob < ApplicationJob
  queue_as :default

  def perform(enrollment)
    instructor = enrollment.course.instructor
    student = enrollment.user
    course = enrollment.course

    NotificationMailer.enrollment_notification(instructor, course, student).deliver_now if instructor.present?
  end
end
