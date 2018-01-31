class User < ActiveRecord::Base
  acts_as_tagger
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :thoughts
end
