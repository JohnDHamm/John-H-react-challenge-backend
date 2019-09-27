# frozen_string_literal: true

class UsersController < ApplicationController
  def appointments
    appointments = User.find(user_params[:id]).appointments

    json_response(appointments)
  end

  def sign_in
    user = User.find_by_username!(user_params[:username])

    return json_response({ error: 'Incorrect password.' }, 401) unless user[:password] == user_params[:password]

    json_response(id: user.id)
  end

  def sign_up
    user = User.new(username: user_params[:username], password: user_params[:password])

    json_response(id: user.id) if user.save!
  end

  private

  def user_params
    params.permit(:id, :username, :password)
  end
end
