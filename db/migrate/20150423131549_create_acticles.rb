class CreateActicles < ActiveRecord::Migration
  def change
    create_table :acticles do |t|
      t.string :request_link
      t.string :title
      t.string :article_id

      t.timestamps null: false
    end
  end
end
