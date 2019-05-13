class ModeratorsController < ApplicationController
    def new
        @moderator = Moderator.new
        @meetings = bbb.get_meetings[:meetings]
    end
    
    def create
        begin
            @moderator = Moderator.new(moderator_params)
            @meetings = bbb.get_meetings[:meetings]

            if @moderator.save
                meeting_id = params[:selected_meeting][:meeting_id]
                if(meeting_id.empty?)
                    flash.now[:danger] = "You must select a meeting to join"
                    render 'new'
                else                 
                    if !bbb.is_meeting_running?(meeting_id)
                        options = { :moderatorPW => @moderator.password }
                        bbb.create_meeting(meeting_id, meeting_id, options)
                    end

                    join_url = bbb.join_meeting_url(meeting_id, @moderator.name, @moderator.password)
                    redirect_to join_url
                end
            else
                render 'new'
            end
        rescue Exception => ex
            flash.now[:danger] = "Failed with error #{ex.message}"
            render "new"
        end 
    end

    private

        def moderator_params 
            params.require(:moderator).permit(:name, :password)
        end
end
