class SectionComment < ApplicationRecord
    belongs_to :section
    belongs_to :complaint
end
