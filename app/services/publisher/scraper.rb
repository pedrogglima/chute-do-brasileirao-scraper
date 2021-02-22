module Publisher
  class Scraper
    def self.publish(exchange, message = {})
      x = channel.fanout("scraper.#{exchange}")
      
      x.publish(message.to_json)
    end

    def self.channel
      @channel ||= connection.create_channel
    end

    # using default settings
    def self.connection
      @connection ||= Bunny.new({host: 'rabbitmq'}).tap do |c|
        c.start
      end
    end
  end
end