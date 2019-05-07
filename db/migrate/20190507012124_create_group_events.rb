class CreateGroupEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :group_events do |t|
      t.integer :status
      t.string :title
      t.string :description
      t.string :name
      t.string :location
      t.date :starts_at
      t.date :ends_at
      t.references :user, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
