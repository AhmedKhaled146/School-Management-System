class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      resource.create_associated_role
      render json: { status: { code: 200, message: 'Signed up successfully.' }, data: resource }, status: :created
    else
      render json: { status: { message: "User couldn't be created: #{resource.errors.full_messages.to_sentence}" } }, status: :unprocessable_entity
    end
  end

  private
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

end
