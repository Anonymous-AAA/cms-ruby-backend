#Complaint contoller for creating,deleting and updating complaints

class ComplaintController < ApplicationController
include JwtHelper
    def create
        fetch_user
        data = JSON.parse(request.body.read)
        puts data
        user = request.env['current_user']
        role = request.env['role']
        id = request.env['id']
        puts user
        puts role
        if role == 'user'
            complaint = Complaint.new(
                user_id: id,
                title: data['title'],
                description: data['description'],
                committee_head_id: type_from_id(data['type']),
                status: 'Open',
                remarks: nil,
                location: data['location'].presence || nil
            )
            if complaint.save
                render json: { Response: 'Complaint Created' }, status: :created
            else
                render json: { error: complaint.errors.full_messages.join(', ') }, status: :unprocessable_entity
            end
        else
            render json: { Response: 'Invalid Role' }, status: :bad_request
        end
    end



    def destroy
        fetch_user
#get id from url
        params = request.path_parameters
        id= params[:id]
        puts "hello world"
        puts "id: #{id}"
        user = request.env['current_user']
        role = request.env['role']
        if role == 'user'
            Complaint.find_by(id: id).destroy
            render json: { Response: 'Complaint Deleted' }, status: :ok
        else
            render json: { Response: 'Invalid Role' }, status: :bad_request
        end
    end

    def update
      fetch_user
      params = request.path_parameters
      data = JSON.parse(request.body.read)
      id= params[:id]
      user = request.env['current_user']
      role = request.env['role']
      if role == 'user'
        Complaint.find_by(id: id).update(
            title: data['title'],
            description: data['description'],
            committee_head_id:type_from_id(data['type']),
            status: 'Open',
            remarks:nil,
            location: data['location']?data['location']:nil
        )
        render json: { Response: 'Complaint Updated' }, status: :ok
      else
        render json: { Response: 'Invalid Role' }, status: :bad_request


      end
    end

    def index
        fetch_user
        user = request.env['current_user']
        role = request.env['role']
        id=request.env['id']
        puts "vbd'mkldf"
        puts user
        puts "id: #{id}"
        if role == 'user'
        complaints = Complaint.where(user_id: id)
        #return in the form {
          #Complaints: [] #
          #}
          #
#for each complaint in complaints change committee_head_id to type using type_from_id

        modified_complaints = complaints.map do |complaint|
          {
            id: complaint.id,
            title: complaint.title,
            description: complaint.description,
            type: id_from_type(complaint.committee_head_id),
            status: complaint.status,
            remarks: complaint.remarks,
            location: complaint.location,
            created_at: complaint.created_at,
            updated_at: complaint.updated_at
          }
        end

        puts modified_complaints
        render json: {
          Complaints: modified_complaints
        }
        else
            render json: { Response: 'Invalid Role' }, status: :bad_request
        end
    end

    def show
        fetch_user
        params = request.path_parameters
        id= params[:id]
        puts "show id: #{id}"
        user = request.env['current_user']
        role = request.env['role']
        if role == 'user'
            complaint = Complaint.find_by(id: id)
            modified_complaint = {
              id: complaint.id,
              title: complaint.title,
              description: complaint.description,
              type: id_from_type(complaint.committee_head_id),
              status: complaint.status,
              remarks: complaint.remarks,
              location: complaint.location,
              created_at: complaint.created_at,
              updated_at: complaint.updated_at
            }
            render json: modified_complaint
        else
            render json: { Response: 'Invalid Role' }, status: :bad_request
        end
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

    def id_from_type(id)
      case id
      when 1
        'Maintainence'
      when 2
        'Academic'
      when 3
        'Hostel'
      when 4
        'Other'
      else
        'Other'
      end
    end
end
