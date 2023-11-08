class CreateCommitteeHeads < ActiveRecord::Migration[7.1]
  def change
    create_table :committee_heads do |t|
      t.string :name,null:false
      t.string :context,null:false
      t.string :email,null:false
      t.string :password,null:false

      t.timestamps
    end

    add_index :committee_heads, :email, unique:true

  end
end
