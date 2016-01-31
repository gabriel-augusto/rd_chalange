class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.belongs_to :segment, index: true
      t.timestamps null: false
    end
  end
end
