class SignupController < ApplicationController
  def create
    begin
      data = JSON.parse(request.body.read)
      hashed_password = data['password']
      puts hashed_password
      case data['role']
      when 'user'
        exist = User.find_by(email: data['email'])
        if exist
          render json: { Response: 'User Already Exists' }, status: :bad_request
        else
          User.create(
            name: data['name'],
            department: data['department'],
            email: data['email'],
            password_digest: hashed_password
          )
          render json: { Response: 'User Created' }, status: :created
        end
      when 'section head'
        exist = Section.find_by(email: data['email'])
        if exist
          render json: { Response: 'User Already Exists' }, status: :bad_request
        else
          Section.create(
            name: data['name'],
            designation: data['designation'],
            email: data['email'],
            password_digest: hashed_password,
            committee_head_id: type_from_id(data['type']),
            is_authorized: false
          )
          render json: { Response: 'User Created' }, status: :created
        end
      else
        render json: { Response: 'Invalid Role' }, status: :bad_request
      end
    rescue JSON::ParserError
      render json: { Response: 'Invalid JSON Format' }, status: :bad_request
    rescue => e
      render json: { Response: 'Error' }, status: :internal_server_error
    end
  end

  private

  def type_from_id(type)
    case type
    when 'Maintainence'
      1
    when 'Academic'
      2
    when 'Hostel'
      3
    when 'Other'
      4
    else
      5
    end
  end
end
