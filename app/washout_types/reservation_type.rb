# frozen_string_literal: true

class ReservationType < WashOut::Type
  map :attributes => {
    "sdf": :string,
    "id": :integer,
  }
end
