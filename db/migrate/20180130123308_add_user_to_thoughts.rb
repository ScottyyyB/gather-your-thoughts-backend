class AddUserToThoughts < ActiveRecord::Migration[5.1]
  def change
    add_reference :thoughts, :user, foreign_key: true
  end
end
