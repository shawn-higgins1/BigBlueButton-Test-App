require 'bigbluebutton_api'

class SessionsController < ApplicationController
    def new
        @session = Session.new
    end    

    def create
        begin
            @session = Session.new(session_params)

            if (@session.save)
                initBBBApi()

                meeting_name = params[:session][:name]
                meeting_id = params[:session][:meeting_id]
                
                options = { :moderatorPW => params[:session][:moderatorPw],
                    :attendeePW => params[:session][:attendeePw],
                    :welcome => params[:session][:welcomeMSG],
                    :dialNumber => params[:session][:dialNum],
                    :logoutURL => params[:session][:logoutURL],
                    :maxParticipants => params[:session][:maxParticipants] }
                
                #@api.create_meeting(meeting_name, meeting_id, options)
                    
                if (params[:session][:join_session].to_i == 1)
                    if (!params[:session][:moderator_name].empty?)
                        url = @api.join_meeting_url(meeting_id, params[:session][:moderator_name], options[:moderatorPW])
                        redirect_to url
                    else
                        flash.now[:danger] = "To automatically join a session you must provide a moderator name"
                        render 'new'
                    end
                else 
                    redirect_to root_path
                end
            else
                render 'new'
            end
        rescue Exception => ex
            flash.now[:danger] = "Failed with error #{ex.message}"
            render 'new'
        end 
    end

    private

        def session_params 
            params.require(:session).permit(:name, :meeting_id, :moderatorPW, 
                :attendeePW, :welcomeMSG, :dialNum, :logoutURL, :maxParticipants, 
                :join_session, :moderator_name)
        end
end
