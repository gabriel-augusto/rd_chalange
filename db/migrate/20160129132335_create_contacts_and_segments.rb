class CreateContactsAndSegments < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.datetime :date_of_birth
      t.string :state
      t.string :position

      t.timestamps null: false
    end

    create_table :segments do |t|
      t.string :title
      t.timestamps null: false
    end

    create_table :contacts_segments, id: false do |t|
      t.belongs_to :contact, index: true
      t.belongs_to :segment, index: true
    end
  end
end
