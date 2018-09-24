# frozen_string_literal: true
class Predictor
  def initialize
    labels = %w(taken_at
                status
                lanes_open
                operational_status)
    training = [
        [1537750624, 'Open', 1, 'no delay', 0],
        [1537740421, 'Open', 2, 'delay', 10]
    ]

    dec_tree = DecisionTree::ID3Tree.new(labels,
                                         training,
                                         0,
                                         taken_at: :continuous,
                                         status: :discrete,
                                         lanes_open: :continuous,
                                         operational_status: :discrete)
    dec_tree.train

    test = [1537750624, 'Open', 1, 'no delay']
    decision = dec_tree.predict(test)
    puts "\nPredicted: #{decision} ... True decision: #{test.last}"
  end
end