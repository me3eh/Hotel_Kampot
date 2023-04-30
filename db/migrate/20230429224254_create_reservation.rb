class CreateReservation < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.date "from"
      t.date "to"
      t.string "room_number"
      t.string "reservation_number"
      t.timestamps
    end
  end
end
