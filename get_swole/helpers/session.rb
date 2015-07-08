module GetSwole
  module Helpers
    module Session
      def current_user
        return @current_user if @current_user
        user_id = request.session[:user_id]
        @current_user = User.find(id: user_id) if user_id
      end
    end
  end
end
