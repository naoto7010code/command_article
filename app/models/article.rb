class Article < ApplicationRecord
  validates :title, presence: true
  validates :text, presence: true

  belongs_to :user
  has_many :comments

  def self.search(search)
    if search != ""
      Article.where('title LIKE(?)', "%#{search}%")
    else
      Article.all
    end
  end
end
