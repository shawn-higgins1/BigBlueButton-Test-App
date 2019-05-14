# frozen_string_literal: true

require "rails_helper"

describe RecordingsController, type: :controller do
    context "Get #index" do
        it "should get index" do
            allow_any_instance_of(BigBlueButton::BigBlueButtonApi).to receive(:get_recordings).and_return(
              recordings: [
                {
                  name: "Example",
                      participants: "3",
                      playback: {
                        format:
                        {
                          type: "presentation"
                        }
                      },
                      metadata: {
                        "gl-listed": "true",
                      }
                },
                {
                  name: "aExamaaa",
                    participants: "5",
                    playback: {
                      format:
                      {
                        type: "other"
                      }
                    },
                    metadata: {
                      "gl-listed": "false",
                    }
                }
              ]
            )

            get :index

            expect(response).to render_template(:index)
            expect(assigns(:recordings)).to eq(
              [
                {
                  name: "aExamaaa",
                      participants: "5",
                      playbacks:
                      [
                        {
                          type: "other"
                        }
                      ],
                      metadata: {
                        "gl-listed": "false",
                      }
                },
                {
                  name: "Example",
                    participants: "3",
                    playbacks:
                        [
                          {
                            type: "presentation"
                          }
                        ],
                    metadata: {
                      "gl-listed": "true",
                    }
                }
              ]
            )
        end
    end

    context 'Delete #destroy' do
        it 'should delete the recording' do
            allow_any_instance_of(BigBlueButton::BigBlueButtonApi).to receive(:delete_recordings).and_return(true)

            delete :destroy, params: { id: 1 }

            expect(response).to redirect_to root_path
            expect(flash[:success]).to be_present
        end
    end
end
