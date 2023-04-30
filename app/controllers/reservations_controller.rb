# frozen_string_literal: true

class ReservationsController < ApplicationController
  soap_service namespace: 'urn:WashOut'

  # Simple case
  soap_action "list",
              :args   => nil,
              :return => { list: { values: [{id: :string, room_number: :integer, from: :string, to: :string}] } }
  def list
    f = Reservation.all.map do |res|
      res.attributes
    end

    hahah = { list: { values: f } }

    render :soap => hahah
  end

  soap_action "get_pdf",
              :args   => { :id => :string },
              :return => :string
  def get_pdf
    file_data = Base64.encode64(File.binread("tmp/ER2023_plakat_final_2704.pdf"))
    render :soap => (file_data)
  end

  soap_action "integers_to_boolean",
              :args => nil,
              :as => 'MyRequest',
              :return => [:boolean]

  # You can use all Rails features like filtering, too. A SOAP controller
  # is just like a normal controller with a special routing.
  # before_filter :dump_parameters
  # def dump_parameters
  #   Rails.logger.debug params.inspect
  # end
end
