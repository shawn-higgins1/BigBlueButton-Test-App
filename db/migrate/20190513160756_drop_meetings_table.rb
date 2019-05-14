# frozen_string_literal: true

class DropMeetingsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :meetings
  end
end
