class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :animal

  validates: :message, presence :true
end
