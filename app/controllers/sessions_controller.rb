require 'bigbluebutton_api'

class SessionsController < ApplicationController
    def new
    end    

    def join
        begin
            initBBBApi()

            meeting_name = "Demo Meeting"
            meeting_id = "demo-meeting"
            moderator_name = params[:user][:name]
            
            options = { :moderatorPW => "54321",
                :attendeePW => "12345",
                :welcome => 'Welcome to my meeting',
                :dialNumber => '1-800-000-0000x00000#',
                :logoutURL => 'https://github.com/mconf/bigbluebutton-api-ruby',
                :maxParticipants => 25 }

            if !@api.is_meeting_running?(meeting_id)
                @api.create_meeting(meeting_name, meeting_id, options)
            end

            @join_url = @api.join_meeting_url(meeting_id, moderator_name, options[:moderatorPW])
            redirect_to @join_url

        rescue Exception => ex
            flash.now[:danger] = "Failed with error #{ex.message}"
            render "new"
        end
    end
end
