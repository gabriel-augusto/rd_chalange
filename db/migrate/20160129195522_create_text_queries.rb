class CreateTextQueries < ActiveRecord::Migration
  def change
    create_table :text_queries do |t|
      t.belongs_to :group, index: true
      t.string :contact_argument
      t.string :value_to_compare
      t.timestamps null: false
    end
  end
end
