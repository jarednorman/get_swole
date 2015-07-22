module GetSwole
  class App < Roda
    plugin :render, engine: 'haml'
    plugin :partials
    plugin :multi_run
    plugin :all_verbs

    plugin(:default_headers,
           'Content-Type' => 'text/html',
           'X-XSS-Protection' => '1; mode=block',
           'X-Content-Type-Options' => 'nosniff',
           'X-Frame-Options' => 'deny')

    use(Rack::Session::Cookie,
        key: '_swole_session',
        secret: ENV['SESSION_SECRET'] || "1234567890")

    use Rack::MethodOverride

    include GetSwole::Helpers::Session
    include GetSwole::Helpers::Asset

    route do |request|
      request.multi_run

      request.root do
        view "index"
      end

      request.on "api" do
        request.on "user/:id" do |id|
          user = User.find(id: id)

          request.post "edit" do
            user.update(request.params["user"])
          end
        end
      end

      request.on "session" do
        request.is do
          request.post do
            user = User.find(email: request.params["email"])

            if user && user.password == request.params["password"]
              request.session[:user_id] = user.id
            end

            request.redirect "/"
          end

          request.delete do
            request.session[:user_id] = nil
            request.redirect "/"
          end
        end
      end
    end
  end
end
