class EmailNotifier < ApplicationRecord
  validates :template, presence: true
  belongs_to :participant
end
