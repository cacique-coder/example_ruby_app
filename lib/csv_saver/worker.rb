module CsvSaver
  class Worker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(file)
      Saver.new(file).execute
    end
  end
end
