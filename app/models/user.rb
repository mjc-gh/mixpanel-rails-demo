class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
    :recoverable, :rememberable, :validatable

  has_many :articles, foreign_key: 'author_id'
  has_many :comments

  before_validation(on: :create) do
    self.public_id ||= SecureRandom.uuid
  end
end
