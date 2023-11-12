# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
    def create
      data = JSON.parse(request.body.read)

      role = data[:role]
      email = data[:email]
      password = data[:password]
  
      user = case data[:role]
             when "section head"
               Section.find_by(email: data[:email])
             when "committee head"
               CommitteeHead.find_by(email: data[:email])
             when "user"
               User.find_by(email: data[:email])
             else
               nil
             end
  
      if user && user.authenticate(data[:password])
        token = encode_token(id: user.id, role: data[:role], user: user)
        render json: { Response: "Login Successful", token: token }
      else
        render json: { Response: "Invalid Credentials" }, status: :bad_request
      end
    end
  end
  