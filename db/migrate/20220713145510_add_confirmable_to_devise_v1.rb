# frozen_string_literal: true

# add confirmable to devise
class AddConfirmableToDeviseV1 < ActiveRecord::Migration[5.2]
  def up
    remove_columns :users, :confirmed_at

    add_column :users, :confirmed_at, :datetime
  end

  def down
    remove_index :users, :confirmation_token
    remove_columns :users, :confirmation_token, :confirmed_at, :confirmation_sent_at
  end
end
