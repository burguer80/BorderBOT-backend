# frozen_string_literal: true

class Predictor
  def initialize
    labels = %w[taken_at
                status
                lanes_open
                operational_status]

    data = Port.training_data
    training = data

     # [[1468990800, "Open", 1, "no delay", 0],
     # [1468987200, "Open", 1, "no delay", 0],
     # [1468987200, "Open", 3, "no delay", 0],
     # [1468991100, "Open", 1, "no delay", 9]]

    dec_tree = DecisionTree::ID3Tree.new(labels,
                                         training,
                                         0,
                                         taken_at: :continuous,
                                         status: :discrete,
                                         lanes_open: :continuous,
                                         operational_status: :discrete)
    dec_tree.train

    test = [1468987200, "Open", 1, "delay", 0]
    decision = dec_tree.predict(test)
    puts "\nPredicted: #{decision} ... True decision: #{test.last}"

    test = [1537802950, "Open", 4, "delay", 0]
    decision = dec_tree.predict(test)
    puts "\nPredicted: #{decision} ... True decision: #{test.last}"

    test = [1468987200, "Open", 2, "no delay", 0]
    decision = dec_tree.predict(test)
    puts "\nPredicted: #{decision} ... True decision: #{test.last}"
  end
end
