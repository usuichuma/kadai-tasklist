class ToppagesController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  def index
    if logged_in?
      @micropost = current_user.microposts.build  # form_with 用
      @pagy, @microposts = pagy(current_user.microposts.order(id: :desc))
    end
  end
end
