# frozen_string_literal: true

require "rails_helper"

describe Session, type: :model do
    before do
        @session = Session.new(name: "Test", meeting_id: "Test", moderatorPw: "test", attendeePw: "test")
    end

    context 'validations' do
        it 'should be valid' do
            expect(@session.valid?).to be true
        end

        it 'name should be present' do
            @session.name = ""
            expect(@session.valid?).to be false
        end

        it 'id should be present' do
            @session.meeting_id = ""
            expect(@session.valid?).to be false
        end

        it 'moderator password should be present' do
            @session.moderatorPw = ""
            expect(@session.valid?).to be false
            expect(@session.errors.count).to eq 1
        end

        it 'attendee password should be present' do
            @session.attendeePw = ""
            expect(@session.valid?).to be false
        end
    end
end
