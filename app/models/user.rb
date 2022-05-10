class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book
  has_many :book_comments, dependent: :destroy

  # フォローをした、されたの関係
  # 自分がフォローする側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 自分がフォローされる関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy


  # 一覧画面で使う
  # 自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed
  # 自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :profile_images, dependent: :destroy
  has_one_attached :profile_image

  # group作成のアソシエーション
  has_many :group_users, dependent: :destroy

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpeg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width,height]).processed
  end

  # フォローした時の処理
  def follow(user_id)
    relationships.create(followed_id: user.id)
  end

  # フォローを外す時の処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user.id).destroy
  end

  # フォローをしているか判定
  def following?(user)
    followings.include?(user)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif search == 'forward'
      User.where("name LIKE?", content+'%')
    elsif search == "backword"
      User.where("name LIKE?", '%'+content)
    else
      User.where('name LIKE?', '%'+content+'%')
    end
  end

end
