class User < ApplicationRecord
  has_secure_password
  has_many :animals, dependent: :destroy

  VALIDATE_CELLPHONE_FORMAT = /\A\(([0-9]{2})\)([0-9]{4,5})(\-?)([0-9]{4})\Z/
  VALIDATE_EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates :name, presence: true
  validates :password, presence: true, length: {minimum:6, maximum: 16}, :if => :password
  validates :email, presence: true, uniqueness: true, format: { with: VALIDATE_EMAIL_FORMAT, message: "formato de email incorreto" }, length:{maximum:100}
  validates :cellphone, presence: true, format: {with: VALIDATE_CELLPHONE_FORMAT, message: "formato do numero de celular incorreto"}
  
  before_save {self.email = email.downcase}
  before_create :generation_validation_token

  def generation_validation_token
    
    self.validation_token = generate_random_token
    self.validation_token_expiry_at = Time.now + 2.days
    
  end

  def validate_user?(token)
    if validation_token_expiry_at > Time.now
      self.is_valid = true
      self.validation_token = nil
      return true if self.save
    else
      return false
    end
  end

  private
    def generate_random_token
      return SecureRandom.alphanumeric(15)
    end
end
