class CreateComplaints < ActiveRecord::Migration[7.1]
  def change
    create_table :complaints do |t|
      t.string :title, null:false
      t.text :description, null:false
      t.string :date, null:false
      t.text :remarks
      t.string :status, null:false
      t.string :location
      t.references :committee_head, null: false, foreign_key: true
      t.references :user,null: false,foreign_key: true

      t.timestamps
    end
  end
end
