class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :group_images, dependent: :destroy
  
  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image

 def get_group_image(width, height)
   unless group_image.attached?
     file_path = Rails.root.join('app/assets/images/default-image.jpeg')
     group_image.attach(io: File.open(file_path), filename: 'default-image.jpeg', content_type: 'image/jpg')
   end
   group_image.variant(resize_to_limit: [width, height]).processed 
 end
  
end
