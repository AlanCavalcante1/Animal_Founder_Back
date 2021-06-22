class AddValidateTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_valid, :boolean, default: false
    add_column :users, :validation_token, :string
    add_column :users, :validation_token_sent_at, :datetime
  end
end
