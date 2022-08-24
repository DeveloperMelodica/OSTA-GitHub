# Setup debugger

# ENV["RUBY_DEBUG_PORT"] = "12345"
# require "debug/start"

list_path = File.join("Ruby-files/", "_scripts.txt")
IO.foreach(list_path) do |name|
  name.strip!
  next if name.empty? || name.start_with?("#")
  puts "Loading #{name}"

  require_relative "Ruby-files/#{name}"
end
