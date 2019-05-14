class RecordingsController < ApplicationController
    def index
        @recordings = format_recordings(bbb.get_recordings)
    end

    def destroy
        bbb.delete_recordings(params[:id])
        flash[:success] = "Successfuly deleted the recording"
        redirect_to root_path
    end

    private
        def format_recordings(api_res)
            api_res[:recordings].each do |r|
                next if r.key?(:error)
                # Format playbacks in a more pleasant way.
                r[:playbacks] = if !r[:playback] || !r[:playback][:format]
                    []
                elsif r[:playback][:format].is_a?(Array)
                    r[:playback][:format]
                else
                    [r[:playback][:format]]
                end
                r.delete(:playback)
            end

            api_res[:recordings].sort_by { |rec| rec[:endTime] }.reverse
        end
end
