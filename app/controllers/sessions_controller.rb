class SessionsController < ApplicationController

  def show
    @result = Session.includes(pair_users: [:user1, :user2]).last
  end

  def create
    @result = GroupeService.new
    @result.call
    if @result.errors.blank?
      redirect_to session_path
    else
      redirect_back fallback_location: root_path
      flash[:errors] = @result.errors
    end
  end
end
