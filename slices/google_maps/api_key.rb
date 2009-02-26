module Google
  
  # By default the 'config/eschaton_google_api_keys.yml' file is used to store key values.
  #
  # In the above file you can use keys for your environments(development, test and production) or you can specify 
  # keys for specific domain names(e.g. www.mydomain.org, testing.localhost). If a key is supplied for the domain that 
  # corresponds to your current domain it will honored over environment keys.
  class ApiKey
    cattr_accessor :key    

    def self.get(options = {})
      unless self.key
        domain_name = options[:domain]
        config_file = options[:config_file] || "#{RAILS_ROOT}/config/eschaton_google_api_keys.yml"

        self.key = if File.exists?(config_file)
                    api_keys = YAML.load_file(config_file)

                    api_keys[domain_name] || api_keys[RAILS_ENV]
                  elsif defined?(GOOGLE_MAPS_API_KEY) # TODO - add deprecation warning to remove this
                    GOOGLE_MAPS_API_KEY
                  else
                    'ABQIAAAActtI8WkgLZcM_n8uvnIYsBTJQa0g3IQ9GZqIMmInSLzwtGDKaBT9A95dZjICm7SeC_GoxpzGlyCdQA'
                  end

        _logger_info "Using google api => #{self.key}"                  
      end
      
      self.key
    end

  end

end