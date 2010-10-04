class SecondsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index; create; end
  def create
    @star = Star.find(params[:star_id])
    if current_user.can_second?(@star)
      current_user.second(@star)
      flash[:notice] = "You seconded #{@star.to_sentence} for '#{truncate(@star.reason, 60, '...')}'"
    end
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "That star doesn't exist."
  ensure
    redirect_to root_path
  end
end
