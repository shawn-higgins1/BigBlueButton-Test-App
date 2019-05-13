class Session < ApplicationRecord
    attr_accessor :join_session, :moderator_name

    validates :name, presence: true
    validates :meeting_id, presence: true
    validates :moderatorPw, presence: true
    validates :attendeePw, presence: true

end
