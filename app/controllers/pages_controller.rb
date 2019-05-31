class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @criteria = params[:criteria][1..-1]
    respond_to do |format|
      format.html { render 'pages/index' }
      format.js # <-- idem
    end
  end
end
