class MapsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    respond_to do |format|
      format.html { render 'users/index' }
      format.js # <-- idem
    end
  end
end
