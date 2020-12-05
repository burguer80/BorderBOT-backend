class Ports::Base
  PREFIX = 'latest_pwt_'

  def prefixed_port_number(port_number)
    "#{PREFIX}#{port_number}"
  end
end