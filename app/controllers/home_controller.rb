class HomeController < ApplicationController
  def index
  end

  def link_expired
  end

  def specialist_created
    @confirmed = params[:confirmed]
  end

  def awaitingConfirmation
  end
end
