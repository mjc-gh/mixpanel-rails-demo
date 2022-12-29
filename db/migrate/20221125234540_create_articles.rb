class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.references :author, to_table: 'users'

      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
