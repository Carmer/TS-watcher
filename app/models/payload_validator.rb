require 'digest/sha1'

module TrafficSpy
  class PayloadValidator
    attr_reader :body, :status, :source

    def initialize(data = nil, identifier)
      @data = JSON.parse(data) unless data.nil?

      @identifier = identifier
      @status = nil
      @body   = nil
      @source = Source.find_by(identifier: @identifier)
      validate
    end

    def sha(thing)
      Digest::SHA1.hexdigest(thing.to_s)
    end

    def validate

      if @data == "" || @data == {} || @data.nil?
        @status = 400
        @body = "Payload cannot be empty"
      elsif Source.find_by(identifier: @identifier).nil?
        @status = 403
        @body = "Identifier does not exist"
      else

      @payload = Payload.new(url: @data["url"],
                  parameters: @data["parameters"],
                  responded_in: @data["respondedIn"],
                  requested_at: @data["requestedAt"],
                  user_agent: @data["userAgent"],
                  source_id: source.id,
                  event_name: @data["eventName"],
                  referred_by: @data["referredBy"],
                  resolution_width: @data["resolutionWidth"],
                  resolution_height: @data["resolutionHeight"],
                  request_type: @data["requestType"],
                  sha: sha(@data),
                  ip: @data["ip"]
                  )

        if @payload.save
          @status = 200
          @body   = "identifier: #{@identifier}"
        else
          @status = 403
          @body   = @payload.errors.full_messages.join(", ")
        end
      end

    end
  end
end
