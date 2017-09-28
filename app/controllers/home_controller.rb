class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    respond_to do |format|
      format.html{
        @question = Question.new

        if params[:tag]
          @feed = Question.tagged_with(params[:tag]).paginate(:per_page => 4,:page=>params[:page])
      else
       @feed=current_user.feed.paginate(:per_page => 4,:page=>params[:page])

   end

}
format.js{  }
end
end
def indexmain
  respond_to do |format|
    format.html{
      @question = Question.new

      if params[:tag]
        @feed = Question.tagged_with(params[:tag]).paginate(:per_page => 4,:page=>params[:page])
    else
        @feed=current_user.feed
        @latestfeed=current_user.latestfeed
        @trendingfeed=current_user.trendingfeed
    end      
}
format.js{  }
end
end
def users_list
  @users=User.all
end
def tags_list
  
end
end
