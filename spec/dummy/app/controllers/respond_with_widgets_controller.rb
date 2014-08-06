class RespondWithWidgetsController < ApplicationController
  respond_to :csv

  def index
    respond_with WidgetWithOptions.all, :style => :full
  end

  def show
    respond_with Widget.find(params[:id])
  end

end
