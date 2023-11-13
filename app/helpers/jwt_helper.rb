# app/helpers/jwt_helper.rb
module JwtHelper
    # require 'jwt'
    def encode_token(payload)
      JWT.encode(payload, 'your-secret-key', 'HS256')
    end

    def decode_token(token)
      JWT.decode(token, 'your-secret-key', true, algorithm: 'HS256')[0]
    end
  end
