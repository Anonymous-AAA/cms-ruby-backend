class CreateSectionComments < ActiveRecord::Migration[7.1]
  def change
    create_table :section_comments,primary_key:[:section_id,:complaint_id] do |t|
      t.integer :section_id
      t.integer :complaint_id
      t.text :comment,null:false

      t.timestamps
    end
  end
end
