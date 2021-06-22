class JsonWebToken 
  Secret = ENV["JWT_SECRET_TOKEN"]
  def self.encode(payload)
    #payload[:exp] = (24).hours.from_now.to_i
    JWT.encode(payload, Secret)
  end
  def self.decode(token)
    begin
      decoded = JWT.decode(token, Secret)
    rescue => exception
      return nil
    end
  end
end
