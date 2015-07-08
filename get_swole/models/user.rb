module GetSwole
  class User < Sequel::Model
    plugin :validation_helpers

    def validate
      super
      validates_presence [:email, :hashed_password]
    end

    def password
      @password ||= BCrypt::Password.new(hashed_password) if hashed_password
    end

    def password=(new_password)
      self.hashed_password = BCrypt::Password.create(new_password) if new_password
    end
  end
end
