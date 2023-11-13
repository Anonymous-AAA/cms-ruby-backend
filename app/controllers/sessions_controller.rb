# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  include JwtHelper

  def create
    data = JSON.parse(request.body.read)

    role = data["role"]
    email = data["email"]
    password = data["password"]

    user = case data['role']
           when "section head"
             Section.find_by(email: data["email"])
           when "committee head"
             CommitteeHead.find_by(email: data["email"])
           when "user"
             User.find_by(email: data["email"])
           else
             nil
           end

    if user && password == user.password_digest
      token = encode_token(id: user.id, role: data["role"], user: user)
      render json: { Response: "Login Successful", token: token }
    else
      render json: { Response: "Invalid Credentials" }, status: :bad_request
    end
  end

  def current
    fetch_user

    user = request.env['current_user']
    role = request.env['role']
    id =request.env['id']
    # get details of user from database using id
user=User.find_by(id: id)
    puts user


    user_data = {
      name: user['name'],
      email: user['email'],
      department: user['department'],
      designation: user['designation'],
      role: role,
      is_authorized: user['is_Authorized'],
    }

    role_label = role == 'user' ? 'User' : role

    render json: { **user_data, role: role_label }
  end

  private

  def fetch_user
    token = request.headers['x-access-token']
    puts token
    unless token
      render json: { error: 'Please authenticate using a valid token' }, status: :unauthorized
      return
    end

    begin
      data = decode_token(token)
      puts data
      request.env['id'] = data['id']
      request.env['current_user'] = data['user']
      request.env['role'] = data['role']

      puts data
    rescue JWT::DecodeError
      render json: { error: 'Please authenticate using a valid token' }, status: :unauthorized
    end
  end
end
