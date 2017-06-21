require 'sinatra/base'
require 'socket'

module EhimeHello
  # Run the test server.
  class Server < Sinatra::Base
    def self.run_server
      set :bind, '0.0.0.0'

      get '/' do
        " #{Socket.gethostname}!!!"
      end

      run!
    end
  end
end
