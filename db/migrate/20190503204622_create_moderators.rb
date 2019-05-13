class CreateModerators < ActiveRecord::Migration[5.2]
  def change
    create_table :moderators do |t|
      t.string :name
      t.string :password

      t.timestamps
    end
  end
end
