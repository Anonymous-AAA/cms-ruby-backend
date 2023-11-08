class CommitteeHead < ApplicationRecord
    has_many :complaints
    has_many :sections
end
