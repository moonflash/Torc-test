# frozen_string_literal: true

# TaxCalculator
# responsible for calculating the sales tax and total price for each item in the input
# and preparing the receipt lines for the receipt
# accepts an array of item objects
# {:quantity, :category, :price, :is_imported}
class TaxCalculator
  TAX_EXEMPT_CATEGORIES = %w[book chocolate pills].freeze

  def initialize(items)
    @items = items
  end

  def result
    total_sales_taxes, total_amount = calculate_totals
    receipt_lines = prepare_receipt_lines
    [receipt_lines, total_sales_taxes, total_amount]
  end

  private

  def calculate_sales_tax(item)
    tax_rate = calculate_tax_rate(item)
    round_up_to_nearest_five_cents(item[:price] * tax_rate)
  end

  def calculate_tax_rate(item)
    tax_rate = 0.1 # Basic sales tax rate
    tax_rate = 0 if TAX_EXEMPT_CATEGORIES.any? { |exempt_category| item[:category].include?(exempt_category) }
    tax_rate += 0.05 if item[:is_imported]
    tax_rate
  end

  def round_up_to_nearest_five_cents(amount)
    (amount / 0.05).ceil * 0.05
  end

  def calculate_totals
    total_sales_taxes = 0
    total_amount = 0

    @items.each do |item|
      sales_tax = calculate_sales_tax(item)
      total_price = calculate_total_price(item[:price], sales_tax, item[:quantity])

      total_sales_taxes += sales_tax * item[:quantity]
      total_amount += total_price
    end

    [total_sales_taxes, total_amount]
  end

  def prepare_receipt_lines
    receipt_lines = []
    @items.each do |item|
      total_price = calculate_total_price(item[:price], calculate_sales_tax(item), item[:quantity])
      receipt_lines << [item[:quantity], item[:category], total_price.round(2)]
    end

    receipt_lines
  end

  def calculate_total_price(price, sales_tax, quantity)
    (price + sales_tax) * quantity
  end
end
