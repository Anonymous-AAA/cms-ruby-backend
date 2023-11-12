class CommitteeHead < ApplicationRecord
    has_many :complaints
    has_many :sections
    has_secure_password
end
