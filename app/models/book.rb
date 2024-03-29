class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search_for(content, method)
    if method == "perfect"
      Book.where(title: content)
    elsif method == "forward"
      Book.where("title LIKE?", content+'%')
    elsif method == "backword"
      Book.where("title LIKE?", '%'+content)
    else
      Book.where('title LIKE?', '%'+content+'%')
    end
  end

end
