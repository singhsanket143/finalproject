class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers ,dependent: :destroy
  has_many :likes,dependent: :destroy
  validates :title ,presence: true,length:{maximum:140}
  acts_as_followable
  acts_as_likeable
  def answerfeed question_id
    	Answer.where(question_id: question_id).order(created_at: :desc)
  end

  def liked_by user_id, question_id
    # Like.where(likeable_type: "Question",liker_id: user_id).length > 0
    # puts "*****************************************************************"
    Like.where(likeable_type: "Question",liker_id: user_id,likeable_id: question_id).length > 0


  end
  def like_string user_id,question_id
    if (liked_by user_id,question_id)
      return "UnLike"
    else
      return "Like"
    end


  end
end
