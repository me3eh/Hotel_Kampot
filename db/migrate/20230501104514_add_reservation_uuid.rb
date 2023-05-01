class AddReservationUuid < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :uuid, :string
  end
end
