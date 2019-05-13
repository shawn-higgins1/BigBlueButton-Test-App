module RecordingsHelper
    def recording_length(playbacks)
      valid_playbacks = playbacks.reject { |p| p[:type] == "statistics" }
      return "0 min" if valid_playbacks.empty?
  
      len = valid_playbacks.first[:length]
      if len > 60
        "#{(len / 60).to_i} hrs #{len % 60} mins"
      elsif len.zero?
        "< 1 min"
      else
        "#{len} min"
      end
    end
end
