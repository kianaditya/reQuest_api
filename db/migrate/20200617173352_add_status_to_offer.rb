class AddStatusToOffer < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :status, :integer, default: 0
  end
end
