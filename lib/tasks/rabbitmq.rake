namespace :rabbitmq do
  desc "Setup routing"
  task :setup do
    require "bunny"

    conn = Bunny.new({host: 'rabbitmq'})
    conn.start

    ch = conn.create_channel

    # get or create exchange
    x = ch.fanout("scraper.scraps")

    # get or create queue (note the durable setting)
    queue = ch.queue("cbf.all", durable: true)

    # bind queue to exchange
    queue.bind("scraper.scraps")

    conn.close
  end
end