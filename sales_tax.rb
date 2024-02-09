# frozen_string_literal: true

require 'byebug'
require_relative 'sales_tax_calculator'

calculator = SalesTaxCalculator.new

puts 'Enter input:'
input = ''
loop do
  line = gets
  break if line.chomp.empty?

  input += line
end

# Output results
puts 'Receipt:'
puts calculator.generate_receipt(input)
