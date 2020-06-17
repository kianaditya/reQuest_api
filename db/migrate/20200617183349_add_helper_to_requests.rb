class AddHelperToRequests < ActiveRecord::Migration[6.0]
  def change
    add_reference :requests, :helper, foreign_key: { to_table: :users }
  end
end
