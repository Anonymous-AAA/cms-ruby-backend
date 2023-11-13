class SignupController <ApplicationController
    def create
      data = JSON.parse(request.body.read)

        case data[:role]
        when "user"
            if User.find_by(email: data[:email])
                render json: { Response: "User Already Exists"}, status: :bad_request
            else
                user=User.new(data)
                user.save
                render json: { Response: "User Created"}, status: :created
            end
        when "section head"

            if Section.find_by(email: data[:email])
                render json: { Response: "User Already Exists"}, status: :bad_request
            else
                user=Section.new(name: data[:name],designation: data[:designation], email: data[:email], password:[:password],committee_head_id:type_from_id([:data[:type]]),is_authorized:false)
                user.save
                render json: { Response: "User Created"}, status: :created
            end
        else
            render json: { Response: "Invalid Role" }, status: :bad_request
        end



    end

    private

    def type_from_id(type)
        case type
        when "Maintainence"
          1
        when "Academic"
          2
        when "Hostel"
          3
        when "Other"
          4
        else
          5
        end
      end
    end
