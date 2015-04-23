class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :source_link
      t.string :keyword
      t.string :value
	
      t.timestamps null: false
    end
  end
end
