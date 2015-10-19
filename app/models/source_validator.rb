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
      @source = Source.new(@data)
      if @source.save
        @status = 200
        @body   = "identifier: #{@source.identifier}"
      elsif @identifier.nil? || @rootUrl.nil?
        @status = 400
        @body   = @source.errors.full_messages.join(", ")
      else
        @status = 403
        @body   = @source.errors.full_messages.join(", ")
      end
    end
  end
end
