class Section < ApplicationRecord
  belongs_to :committee_head
  has_secure_password
end
