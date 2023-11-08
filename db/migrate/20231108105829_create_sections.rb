class CreateSections < ActiveRecord::Migration[7.1]
  def change
    create_table :sections do |t|
      t.string :name, null:false 
      t.boolean :is_authorized, null:false
      t.string :designation, null:false
      t.string :email, null:false
      t.string :password, null:false
      t.references :committee_head, null: false, foreign_key: true

      t.timestamps
    end

    add_index :sections, :email, unique:true
  end
end
