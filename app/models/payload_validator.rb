require 'digest/sha1'

module TrafficSpy
  class PayloadValidator
    attr_reader :body, :status
    def initialize(data = nil, identifier)
     if !data.nil?
        @payload = JSON.parse(data)
      else
        @payload = data
      end

      @identifier = identifier
      @status = nil
      @body   = nil
      validate
    end

    def sha(thing)
      Digest::SHA1.hexdigest(thing.to_s)
    end

    def validate
      source = Source.find_by(identifier: @identifier)
      if @payload == "" || @payload == {} || @payload.nil?
        @status = 400
        @body = "Payload cannot be empty"
      elsif Source.find_by(identifier: @identifier).nil?
        @status = 403
        @body = "Identifier does not exist"
      else

      @p = Payload.new(url: @payload["url"],
                  parameters: @payload["parameters"],
                  responded_in: @payload["respondedIn"],
                  requested_at: @payload["requestedAt"],
                  user_agent: @payload["userAgent"],
                  source_id: source.id,
                  event_name: @payload["eventName"],
                  referred_by: @payload["referredBy"],
                  resolution_width: @payload["resolutionWidth"],
                  resolution_height: @payload["resolutionHeight"],
                  request_type: @payload["requestType"],
                  sha: sha(@payload),
                  ip: @payload["ip"]
                  )

        if @p.save
          @status = 200
          @body   = "identifier: #{@identifier}"
        else
          @status = 403
          @body   = @p.errors.full_messages.join(", ")
        end
      end

    end
  end
end
