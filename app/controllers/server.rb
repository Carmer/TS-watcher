module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      source = SourceValidator.new(params)
      response.status  = source.status
      response.body  = source.body
    end

    post '/sources/:identifier/data' do |identifier|
      payload = PayloadValidator.new(params["payload"], identifier)
      response.body = payload.body
      response.status = payload.status
    end
  end
end
