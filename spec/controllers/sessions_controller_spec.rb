# frozen_string_literal: true

require "rails_helper"

describe SessionsController, type: :controller do
    context 'get #new' do
        it "should get a new session" do
            get :new

            expect(response).to render_template(:new)
            expect(assigns(:session)).to be_kind_of(Session)
        end
    end

    context 'failed post to #create' do
        render_views

        it 'should fail to save session' do
            post :create, params: { session: { name: "test", meeting_id: "test" } }

            expect(response).to render_template(:new)
            expect(response.body).to include 'The form contains 2 errors'
        end
    end

    context 'successfuly post to #create' do
        before do
            allow_any_instance_of(BigBlueButton::BigBlueButtonApi).to receive(:create_meeting).and_return(true)
        end

        it 'should successfully create a session' do
            post :create, params: { session: { name: "test", meeting_id: "test", moderatorPw: "a", attendeePw: "a" } }

            expect(response).to redirect_to root_path
            expect(flash[:success]).to be_present
        end

        it 'should fail to automatically join the meeting' do
            post :create, params: { session: { name: "test", meeting_id: "test", moderatorPw: "a",
                attendeePw: "a", moderator_name: "", join_session: 1 } }

            expect(response).to redirect_to root_path
            expect(flash[:danger]).to be_present
        end

        it 'should successfully join the meeting' do
            allow_any_instance_of(BigBlueButton::BigBlueButtonApi).to receive(:join_meeting_url)
              .and_return("https://blindsidenetworks.com/")

            post :create, params: { session: { name: "test", meeting_id: "test", moderatorPw: "a",
                attendeePw: "a", moderator_name: "test", join_session: 1 } }

            expect(response).to redirect_to "https://blindsidenetworks.com/"
        end
    end
end
