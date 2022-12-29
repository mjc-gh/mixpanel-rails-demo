class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :article
      t.references :posted_by, to_table: 'users'

      t.text :body

      t.timestamps
    end
  end
end
