# frozen_string_literal: true

class Reservation < ApplicationRecord
  def attributes
    {
      'id': id,
      "room_number": room_number,
      'from': from.strftime("%d/%m/%Y"),
      'to': to.strftime("%d/%m/%Y"),
    }
  end
end
