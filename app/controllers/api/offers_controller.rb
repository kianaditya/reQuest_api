# frozen_string_literal: true

class Api::OffersController < ApplicationController
  before_action :authenticate_user!

  def create
    offer = Offer.create(check_and_convert_parameters)
    if offer.persisted?
      render json: { message: 'Your offer has been sent!' }
    else
      render json: { message: offer.errors.full_messages.join(". ") }, status: 422
    end
  rescue StandardError => e
    render json: { message: e.message }, status: 422
  end

  def update
    offer = Offer.find(params[:id])
    
    if offer.update(status: params[:activity])
      render json: ''
    else

    end


  end 

  def show
    offer = current_user.offers.find(params[:id])

    if offer
      case offer.status
      when 'pending'
        message = 'Your offer is pending'
      when 'approved'
        message = 'Your offer has been accepted'
      when 'declined'
        message = 'Your offer has been declined'
      end
      
      render json: {offer: offer, status_message: message} 
    else
      render json: {error_message: 'Offer cannot be found'}
    end
  end

  private

  def check_and_convert_parameters
    target_request = Request.find(params[:request_id])
    if target_request.requester == current_user
      raise StandardError, 'You cannot offer help on your own request!'
    end

    { helper: current_user, request: target_request, message: params[:message] }
  end
end
