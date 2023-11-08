class Complaint < ApplicationRecord
  belongs_to :committee_head
  belongs_to :user
end
