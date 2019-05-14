require "rails_helper"

describe Moderator, type: :model do
    before do
        @moderator = Moderator.new(name: "Example User", password: "test")
    end

    context 'validations' do
        it 'should be valid' do
            expect(@moderator.valid?).to be true
        end

        it 'name should be present' do
            @moderator.name = ""
            expect(@moderator.valid?).to be false
        end

        it 'password should be present' do
            @moderator.password = ""
            expect(@moderator.valid?).to be false
        end
    end
end