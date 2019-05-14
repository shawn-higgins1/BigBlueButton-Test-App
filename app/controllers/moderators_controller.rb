# frozen_string_literal: true

class ModeratorsController < ApplicationController
    def new
        @moderator = Moderator.new
        @meetings = bbb.get_meetings[:meetings]
    end

    def create
            @moderator = Moderator.new(moderator_params)
            @meetings = bbb.get_meetings[:meetings]

            if @moderator.save
                meeting_id = params[:selected_meeting][:meeting_id]
                if meeting_id.empty?
                    flash.now[:danger] = "You must select a meeting to join"
                    render 'new'
                else
                    join_url = bbb.join_meeting_url(meeting_id, @moderator.name,
                        @moderator.password, joinViaHtml5: true)
                    redirect_to join_url
                end
            else
                render 'new'
            end
    rescue StandardError => e
            flash.now[:danger] = "Failed with error #{e.message}"
            render "new"
    end

  private

    def moderator_params
        params.require(:moderator).permit(:name, :password)
    end
end
