# Include hook code here

require 'json'

# Include hook code here
gigglya_config = "#{RAILS_ROOT}/config/gigya.yml"

require 'giggly'
Giggly.load_configuration(gigglya_config)

