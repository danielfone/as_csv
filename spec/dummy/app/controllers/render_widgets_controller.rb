class RenderWidgetsController < ApplicationController

  def index
    respond_to do |format|
      format.csv { render csv: WidgetWithOptions.scoped, style: :full }
    end
  end

  def show
    respond_to do |format|
      format.csv { render csv: Widget.find(params[:id]) }
    end
  end

end
