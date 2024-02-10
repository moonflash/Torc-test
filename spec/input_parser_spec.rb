# frozen_string_literal: true

require 'rspec'
require_relative '../lib/input_parser'

describe InputParser do
  describe '.parse' do
    it 'splits the input string into an array of lines' do
      input = "2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85"
      expected_output = [
        { quantity: 2, category: 'book', price: 12.49, is_imported: false },
        { quantity: 1, category: 'music CD', price: 14.99, is_imported: false },
        { quantity: 1, category: 'chocolate bar', price: 0.85, is_imported: false }
      ]

      expect(InputParser.parse(input)).to eq(expected_output)
    end

    it 'returns an empty array when the input is an empty string' do
      expect(InputParser.parse('')).to eq([])
    end
  end
end
