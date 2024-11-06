class ApplicationController < ActionController::API
  include Pundit
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[password password_confirmation first_name last_name email role department_id])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end

  private

  # Pagination Logic.
  def pagination_meta(records)
    {
      current_page: records.current_page,
      next_page: records.next_page,
      prev_page: records.prev_page,
      total_pages: records.total_pages,
      total_count: records.total_count
    }
  end

  # Render Errors in actions.
  def render_errors(object, message = "An error occurred")
    render json: {
      errors: object.errors,
      status: :unprocessable_entity,
      message: message
    }, status: :unprocessable_entity
  end

  # Record Not Found Method.
  def record_not_found(resource = "Record")
    render json: {
      errors: "#{resource} not found",
      status: :not_found,
      message: "Could not find the requested #{resource}"
    }, status: :not_found
  end

  # User Not Authorized Handle.
  def user_not_authorized
    render json: {
      status: { code: 403, message: "You are not authorized to perform this action." }
    }, status: :forbidden
  end

end
