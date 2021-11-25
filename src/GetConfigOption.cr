require "json"

content = File.open(ARGV[0]) do |file|
  JSON.parse(file)
end

if content[ARGV[1]]?
  value = content[ARGV[1]]
else
  raise "Could not find option #{ARGV[1]} in config file #{ARGV[0]}."
end

class_str = "?"

# For some reason, sometimes the bool detection is off
if value.as_bool? || value.to_s == "true" || value.to_s == "false"
  class_str = "B"
elsif value.as_i?
  class_str = "I"
elsif value.as_s?
  class_str = "S"
elsif value.as_f?
  class_str = "F"
elsif value.as_a?
  class_str = "A"
else
  puts "NOTE: Value #{value} has incompatible class."
end

puts class_str + "|" + content[ARGV[1]].to_s