# frozen_string_literal: true

class RumbasController < ApplicationController
  soap_service namespace: 'urn:WashOut'

  # Simple case
  soap_action "integer_to_string",
              :args   => :integer,
              :return => :string
  def integer_to_string
    render :soap => params[:value].to_s
  end

  soap_action "concat",
              :args   => { :a => :string, :b => :string },
              :return => :string
  def concat
    render :soap => (params[:a] + params[:b])
  end

  soap_action "integers_to_boolean",
              :args => { :my_request => { :data => [:integer] } },
              :as => 'MyRequest',
              :return => [:boolean]

  # You can use all Rails features like filtering, too. A SOAP controller
  # is just like a normal controller with a special routing.
  before_filter :dump_parameters
  def dump_parameters
    Rails.logger.debug params.inspect
  end
end
