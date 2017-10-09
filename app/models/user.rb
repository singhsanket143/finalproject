class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :confirmable, :recoverable, :rememberable, :trackable, :validatable
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notes, dependent: :destroy
    has_many :follows, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id
  enum role: {guest: 0, member: 1, moderator: 2, admin: 3}
  validates :phno, length: {is: 10}
  validates :name, presence: true
  mount_uploader :avatar, AvatarUploader
  acts_as_followable
  acts_as_liker
  acts_as_follower
  def feed
    Question.includes(:user).order(created_at: :desc)
  end
  def trendingfeed
  Question.last(6).reverse
  end
  def latestfeed
  Question.last(6).reverse
  end

  def followed_by user_id, follow_id
   Follow.where(followable_type: "User",follower_id: user_id,followable_id: follow_id).length > 0
  end
 
  def follow_string user_id,follow_id
    if (followed_by user_id,follow_id)
      return true
    else
      return false
    end
   end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name=auth.info.name
      user.skip_confirmation!
    end
  end

  def self.new_with_session(params,session)
    if session["devise.user_Attributes"]
      new(session["devise.user_Attributes"],without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  # def password_required?
  #   super && provider.blank?
  # end
end
