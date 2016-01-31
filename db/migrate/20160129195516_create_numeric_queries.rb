class CreateNumericQueries < ActiveRecord::Migration
  def change
    create_table :numeric_queries do |t|
      t.belongs_to :group, index: true
      t.string :contact_argument
      t.integer :min_value
      t.integer :max_value
      t.timestamps null: false
    end
  end
end
