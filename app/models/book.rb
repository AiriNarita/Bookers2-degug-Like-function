class Book < ApplicationRecord
  
  belongs_to :user
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  validates :category,presence:true

  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  #sort-function
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end   

  #閲覧数
  has_many :view_counts, dependent: :destroy
  
  # 検索機能
  
  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%'+content)
    else
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end
  
end
