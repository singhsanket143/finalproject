

  class SocializationsController < ApplicationController
  before_filter :load_socializable

  def follow
    current_user.toggle_follow!(@socializable)
    respond_to do |format|
      format.js {}
    end
  end

  def like
    @question=Question.find(params[:question_id])
    like=Like.where(likeable_type: "Question",liker_id: current_user.id).first
    if like
      current_user.toggle_like!(@socializable)
      @is_liked=false
    else
      current_user.toggle_like!(@socializable)
      @is_liked=true
    end


    respond_to do |format|
      format.js {}
    end
  end

  private
  def load_socializable
    @socializable =
        case
          when id = params[:question_id] # Must be before :item_id, since it's nested under it.
            Question.find(id)
          when id = params[:user_id]
            User.find(id)
          when id = params[:user_id]
            User.find(id)

          when id = params[:maintrend_id]
            Maintrend.find(id)

          when id = params[:subtrend_id]
            Subtrend.find(id)
          # when id = params[:category_id]
          #   @community.categories.find_by_id(id)

          else
            raise ArgumentError, "Unsupported socializable model, params: "
            params.keys.inspect
        end
    raise ActiveRecord::RecordNotFound unless @socializable
  end
end