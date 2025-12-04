class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable,
  # :timeoutable,
  # :omniauthable
  # :registerable
  devise :database_authenticatable,
         :lockable,
         :trackable,
         :recoverable,
         :rememberable,
         :validatable
end
