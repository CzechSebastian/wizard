class MapsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @districts = District.all.sample(3)
    # @districts = District.select
    respond_to do |format|
      format.html { render 'users/index' }
      format.js # <-- idem
    end
  end
end
