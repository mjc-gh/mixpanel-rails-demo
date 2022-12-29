class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :posted_by, class_name: 'User'

  validates :body, length: { in: 3..1000 }
end
