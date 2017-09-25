class HomeController < ApplicationController
    before_action :authenticate_user!
  def index
      respond_to do |format|
        format.html{
          @question = Question.new
          @feed=current_user.feed.paginate(:per_page => 4,:page=>params[:page])
        }
        format.js{  }
      end
  end
    def users_list
      @users=User.all
    end
end
