class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string :name
      t.string :meeting_id
      t.string :moderatorPw
      t.string :attendeePw
      t.text :welcomeMSG
      t.string :dialNum
      t.string :logoutURL
      t.integer :maxParticipants

      t.timestamps
    end
  end
end
