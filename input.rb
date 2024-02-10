# frozen_string_literal: true

require_relative 'tax_calculator'

puts 'Enter input:'
input = ''
loop do
  line = gets
  break if line.chomp.empty?

  input += line
end

# Output results
puts 'Receipt:'
puts TaxCalculator.new.generate_receipt(input)
