class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.integer :age
      t.string :state
      t.string :position

      t.timestamps null: false
    end
  end
end
