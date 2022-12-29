class AddMixpanelProfileLastSetAtToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.datetime :mixpanel_profile_last_set_at
    end
  end
end
