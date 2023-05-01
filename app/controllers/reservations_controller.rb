# frozen_string_literal: true

class ReservationsController < ApplicationController
  soap_service namespace: 'urn:WashOut'

  before_action :dump_parameters
  def dump_parameters
    puts " asdfasdfasdfasdfasfasdf\n\n\n\n\n\nasdfasdfasfasdfasdfasdfasdf"
  end
  # Simple case
  soap_action "list",
              :args   => nil,
              :return => { list: { values: [{id: :string, room_number: :integer, from: :string, to: :string}] } }
  def list
    open_reservations = Reservation.where(uuid: nil)
    raise SOAPError, "There are no reservations left" if open_reservations.empty?

    f = open_reservations.map do |res|
      res.attributes
    end

    hahah = { list: { values: f } }

    render :soap => hahah
  end

  soap_action "get_pdf",
              :args   => { :id => :string },
              :return => { pdf: :string, pdf_name: :string }
  def get_pdf
    reservation = Reservation.find_by(id: params[:id])
    uuid = SecureRandom.uuid
    reservation.update(uuid: uuid)
    filename = "#{uuid}.pdf"

      ::Prawn::Document.generate("tmp/#{filename}") do
        text "Hello there",
             size: 36, align: :center, leading: 2
        text "Room number: #{reservation.id}"
        text "From: #{reservation.from}"
        text "To: #{reservation.to}"
        text "REMEMBER - your reservation name: #{reservation.uuid}"
      end

    file_data = Base64.encode64(File.binread("tmp/#{filename}"))
    render :soap => { pdf: (file_data), pdf_name: filename }
  end

  soap_action "get_reservation_by_code",
              :args   => { :id => :string },
              :return => { value: {id: :string, room_number: :integer, from: :string, to: :string} }
  def get_reservation_by_code
    reservation = Reservation.find_by(uuid: params[:id])
    raise SOAPError, "There is no reservation with such uuid" if reservation.nil?

    reservation_hash =
      {
        id: reservation.id,
        room_number: reservation.room_number,
        from: reservation.from,
        to: reservation.to
      }

    render soap: { value: reservation_hash }
  end
end
