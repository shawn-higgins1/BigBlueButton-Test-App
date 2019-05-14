require "rails_helper"

describe ModeratorsController, type: :controller do
    before do
        allow_any_instance_of(BigBlueButton::BigBlueButtonApi).to receive(:get_meetings).and_return(
            {
                meetings:[
                    {
                        meetingName: "test1",
                        meetingID: "test1"
                    },
                    {
                        meetingName: "test2",
                        meetingID: "test2"
                    }
                ]
            }
        )
    end

    context 'get #new' do
        it 'should get a new moderator' do
            get :new

            expect(response).to render_template(:new)
            expect(assigns(:moderator)).to be_kind_of(Moderator) 
            expect(assigns(:meetings)).to eq(
                [
                    {
                        meetingName: "test1",
                        meetingID: "test1"
                    },
                    {
                        meetingName: "test2",
                        meetingID: "test2"
                    }
                ]
            )
        end
    end

    context 'post #create' do
        render_views

        it 'should fail to save the moderator' do
            post :create, params: {moderator: {name: "test"}}

            expect(response).to render_template(:new)
            expect(response.body).to include 'The form contains 1 error'
            expect(assigns(:moderator)).to be_kind_of(Moderator) 
            expect(assigns(:meetings)).to eq(
                [
                    {
                        meetingName: "test1",
                        meetingID: "test1"
                    },
                    {
                        meetingName: "test2",
                        meetingID: "test2"
                    }
                ]
            )
        end 

        it 'should fail to join because no meeting was selected' do
            post :create, params: {moderator: {name: "test", password: "test"}, selected_meeting: {meeting_id: ""}}

            expect(response).to render_template(:new)
            expect(flash[:danger]).to be_present
            expect(assigns(:moderator)).to be_kind_of(Moderator) 
            expect(assigns(:meetings)).to eq(
                [
                    {
                        meetingName: "test1",
                        meetingID: "test1"
                    },
                    {
                        meetingName: "test2",
                        meetingID: "test2"
                    }
                ]
            )
        end 

        it 'should successfully join the meeting' do
            allow_any_instance_of(BigBlueButton::BigBlueButtonApi).to receive(:join_meeting_url).and_return("https://blindsidenetworks.com/")

            post :create, params: {moderator: {name: "test", password: "test"}, selected_meeting: {meeting_id: "test"}}

            expect(response).to redirect_to "https://blindsidenetworks.com/"
        end
    end
end