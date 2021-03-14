class BuddyScheme < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
end
