class AddPublicIdToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.string    :public_id, null: false
    end

    add_index :users, :public_id, unique: true
  end
end
