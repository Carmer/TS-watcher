module TrafficSpy
  class SourceValidator
    attr_reader :status, :body

    def initialize(data)
      @identifier = data["identifier"]
      @rootUrl = data["rootUrl"]
      @data = data
      @status = nil
      @body = nil
      validate
    end

    def validate
      source = Source.new(@data)
      require "pry"; binding.pry
      if @identifier.nil? || @rootUrl.nil?
        @status = 400
        @body   = "One or more parameters is missing.
                  Please check your request and resend."
      elsif source.save
        @status = 200
        @body   = {"identifier": "#{source.identifier}" }
      else
        @status = 303
        @body   = source.errors.full_messages.join(", ")
      end
    end
  end
end
