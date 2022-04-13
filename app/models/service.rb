class Service < ApplicationRecord
    has_many :service_blocks
    include PgSearch::Model

    pg_search_scope :search, against: [:id, :name]

    include AASM
    aasm whiny_transitions: false do

        state :active, initial: true
        state :deactive

        event :activate do
        transitions from: :deactive, to: :active
        end

        event :deactivate do
        transitions from: :active, to: :deactive
        end

    end

end
