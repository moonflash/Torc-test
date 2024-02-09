# frozen_string_literal: true

require 'rspec'
require_relative 'sales_tax'

describe SalesTaxCalculator do # rubocop:disable Metrics/BlockLength
  let(:calculator) { SalesTaxCalculator.new }

  describe '#generate_receipt' do # rubocop:disable Metrics/BlockLength
    context 'when given valid input1' do
      let(:input) do
        "2 book at 12.49\n 1 music CD at 14.99\n 1 chocolate bar at 0.85"
      end

      it 'returns the correct receipt, total sales taxes, and total amount' do
        receipt, total_sales_taxes, total_amount = calculator.generate_receipt(input)
        expect(receipt).to eq("2 book: 24.98\n 1 music CD: 16.49\n 1 chocolate bar: 0.85")
        expect(total_sales_taxes).to eq('Sales Taxes: 1.50')
        expect(total_amount).to eq('Total: 42.32')
      end
    end

    context 'when given valid input2' do
      let(:input) { "1 imported box of chocolates at 10.00\n 1 imported bottle of perfume at 47.50" }

      it 'returns an empty receipt, zero total sales taxes, and zero total amount' do
        receipt, total_sales_taxes, total_amount = calculator.generate_receipt(input)
        expect(receipt).to eq("1 imported box of chocolates: 10.50\n 1 imported bottle of perfume: 54.65")
        expect(total_sales_taxes).to eq('Sales Taxes: 7.65')
        expect(total_amount).to eq('Total: 65.15')
      end
    end

    context 'when given valid input3' do
      let(:input) do
        "1 imported bottle of perfume at 27.99\n 1 bottle of perfume at 18.99\n 1 packet of headache pills at 9.75\n 3 imported boxes of chocolates at 11.25"
      end

      it 'returns an empty receipt, zero total sales taxes, and zero total amount' do
        receipt, total_sales_taxes, total_amount = calculator.generate_receipt(input)
        expect(receipt).to eq("1 imported bottle of perfume: 32.19\n 1 bottle of perfume: 20.89\n 1 packet of headache pills: 9.75\n 3 imported boxes of chocolates: 35.55")
        expect(total_sales_taxes).to eq('Sales Taxes: 7.90')
        expect(total_amount).to eq('Total: 98.38')
      end
    end
  end
end
