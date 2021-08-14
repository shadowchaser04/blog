class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.integer :pagecount
      t.boolean :published
      t.datetime :published_at
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end
  end
end
