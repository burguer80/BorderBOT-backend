# frozen_string_literal: true

class Predictor
  ATTRIBUTES = %w[taken_at
                status
                lanes_open
                operational_status].freeze

  def initialize

    data = Port.training_data
    training_data = data

    @dec_tree = DecisionTree::ID3Tree.new(ATTRIBUTES,
                                          training_data,
                                          0,
                                          taken_at: :continuous,
                                          status: :discrete,
                                          lanes_open: :continuous,
                                          operational_status: :discrete)
    train

    test = [1468987200, "Open", 1, "delay", 0]
    decision = @dec_tree.predict(test)
    puts "\nPredicted: #{decision} ... True decision: #{test.last}"

    test = [1537802950, "Open", 4, "delay", 0]
    decision = @dec_tree.predict(test)
    puts "\nPredicted: #{decision} ... True decision: #{test.last}"

    test = [1468987200, "Open", 2, "no delay", 0]
    decision = @dec_tree.predict(test)
    puts "\nPredicted: #{decision} ... True decision: #{test.last}"
  end

  def predict(data)
    @dec_tree.predict(data)
  end

  private

  def train
    started_at = Time.now
    puts 'Training started'
    @dec_tree.train
    finished_at = Time.now - started_at
    puts "Training Finished in #{finished_at.to_i} seconds."
  end
end
