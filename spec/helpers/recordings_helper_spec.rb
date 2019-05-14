# frozen_string_literal: true

require "rails_helper"

describe RecordingsHelper do
  describe "#recording_length" do
    it "returns the time if length > 60" do
      playbacks = [{ type: "statistics", length: 85 }, { type: "test", length: 85 }]
      expect(helper.recording_length(playbacks)).to eql("1 hrs 25 mins")
    end

    it "returns the time if length == 0" do
      playbacks = [{ type: "test", length: 0 }]
      expect(helper.recording_length(playbacks)).to eql("< 1 min")
    end

    it "returns the time if length between 0 and 60" do
      playbacks = [{ type: "test", length: 45 }]
      expect(helper.recording_length(playbacks)).to eql("45 min")
    end

    it "returns 0 if playbacks is empty" do
      playbacks = [{ type: "statistics", length: 45 }]
      expect(helper.recording_length(playbacks)).to eql("0 min")
    end
  end
end
