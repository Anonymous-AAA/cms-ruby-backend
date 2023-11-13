# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
include JwtHelper
    def create
      data = JSON.parse(request.body.read)

      role = data["role"]
      email = data["email"]
      password = data["password"]

      puts email
      # puts password
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


      puts user.password_digest
      puts password

      if user && password == user.password_digest
        token = encode_token(id: user.id, role: data["role"], user: user)
        render json: { Response: "Login Successful", token: token }
      else
        render json: { Response: "Invalid Credentials" }, status: :bad_request
      end
    end
  end
