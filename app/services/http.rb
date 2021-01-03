# frozen_string_literal: true

class Http
  def initialize(url)
    @uri = URI(url)
  end
end
