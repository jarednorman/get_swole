module GetSwole
  class User < Sequel::Model
    set_allowed_columns :one_rep_max_bench, :one_rep_max_deadlift,
      :one_rep_max_military, :one_rep_max_squat

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
