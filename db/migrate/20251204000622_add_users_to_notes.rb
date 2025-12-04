class AddUsersToNotes < ActiveRecord::Migration[8.1]
  # @note NOTES TABLE MUST BE EMPTY
  def change
    add_reference :notes, :user, null: false, foreign_key: true
  end
end
