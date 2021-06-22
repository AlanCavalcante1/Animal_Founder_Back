class User < ApplicationRecord
  has_secure_password

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
