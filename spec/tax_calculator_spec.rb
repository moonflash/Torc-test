# frozen_string_literal: true

require 'rspec'
require_relative '../lib/tax_calculator'

describe TaxCalculator do # rubocop:disable Metrics/BlockLength
  describe '#result' do # rubocop:disable Metrics/BlockLength
    context 'when given valid input1' do
      it 'returns receipt lines, total sales taxes, and total amount for given items' do
        items = [
          { quantity: 2, category: 'book', price: 12.49, is_imported: false },
          { quantity: 1, category: 'music CD', price: 14.99, is_imported: false },
          { quantity: 1, category: 'chocolate bar', price: 0.85, is_imported: false }
        ]
        tax_calculator = TaxCalculator.new(items)

        expected_output = [
          [[2, 'book', 24.98], [1, 'music CD', 16.49], [1, 'chocolate bar', 0.85]],
          1.5, # total sales taxes
          42.32 # total amount
        ]

        expect(tax_calculator.result).to eq(expected_output)
      end
    end

    context 'when given valid input2' do
      it 'returns receipt lines, total sales taxes, and total amount for given items' do
        items = [
          { quantity: 1, category: 'imported box of chocolates', price: 10.0, is_imported: true },
          { quantity: 1, category: 'imported bottle of perfume', price: 47.5, is_imported: true }
        ]
        tax_calculator = TaxCalculator.new(items)

        expected_output = [
          [[1, 'imported box of chocolates', 10.5], [1, 'imported bottle of perfume', 54.65]],
          7.65,
          65.15
        ]

        expect(tax_calculator.result).to eq(expected_output)
      end
    end

    context 'when given valid input3' do
      it 'returns receipt lines, total sales taxes, and total amount for given items' do
        items = [
          { quantity: 1, category: 'imported bottle of perfume', price: 27.99, is_imported: true },
          { quantity: 1, category: 'bottle of perfume', price: 18.99, is_imported: false },
          { quantity: 1, category: 'packet of headache pills', price: 9.75, is_imported: false },
          { quantity: 3, category: 'imported boxes of chocolates', price: 11.25, is_imported: true }
        ]
        tax_calculator = TaxCalculator.new(items)

        expected_output = [
          [
            [1, 'imported bottle of perfume', 32.19],
            [1, 'bottle of perfume', 20.89],
            [1, 'packet of headache pills', 9.75],
            [3, 'imported boxes of chocolates', 35.55]
          ], 7.9, 98.38
        ]

        expect(tax_calculator.result).to eq(expected_output)
      end
    end
  end
end
