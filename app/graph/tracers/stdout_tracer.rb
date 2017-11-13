class StdoutTracer
  def self.trace(key, data)
    if key == 'execute_field'
      puts "#{key}: #{data[:context].path}"
    else
      puts key
    end
    yield
  end
end
