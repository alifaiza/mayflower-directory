class CreateResidents < ActiveRecord::Migration[5.0]
  def change
    create_table :residents do |t|
      t.string :first_name,  null: false, default: ""
      t.string :last_name,   null: false, default: ""
      

      t.timestamps
    end
    
    add_index :residents, :first_name, unique: true
    add_index :residents, :last_name,  unique: true
  end
end
