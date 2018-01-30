class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  # validates_presence_of :password, on: :create
  # validates :password,
  #   length: { minimum: 8 },
  #   allow_blank: true
  # validate  :password_complexity
  # validates_confirmation_of :password
  # validates_presence_of :password_confirmation, if: lambda {| u| u.password.present? }
  #
  # private
  #
  #  def password_complexity
  #    return unless :password
  #    if !:password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)./)
  #      errors.add(:password, "Must include at least one lowercase letter, one uppercase letter and one digit")
  #    end
  #  end

  include DeviseTokenAuth::Concerns::User
end
