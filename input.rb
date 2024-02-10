# frozen_string_literal: true

require_relative 'lib/tax_calculator'
require_relative 'lib/input_parser'
require_relative 'lib/receipt'

puts 'Enter input:'
input = ''
loop do
  line = gets
  break if line.chomp.empty?

  input += line
end

# Output results
puts 'Receipt:'
items = InputParser.parse(input)
receipt_lines, total_sales_taxes, total_amount = TaxCalculator.new(items).result
puts Receipt.new(receipt_lines, total_sales_taxes, total_amount).print
