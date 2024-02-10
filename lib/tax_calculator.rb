# frozen_string_literal: true

# Sales tax calculator class
class TaxCalculator
  TAX_EXEMPT_CATEGORIES = %w[book chocolate pills].freeze

  def generate_receipt(input)
    items = parse_input(input)
    total_sales_taxes, total_amount = calculate_totals(items)
    receipt_lines = prepare_receipt(items)

    receipt = receipt_lines.join("\n")
    [receipt, sales_tax_presenter(total_sales_taxes), total_amount_presenter(total_amount)]
  end

  private

  def calculate_sales_tax(price, is_imported, category)
    tax_rate = calculate_tax_rate(is_imported, category)
    round_up_to_nearest_five_cents(price * tax_rate)
  end

  def calculate_tax_rate(is_imported, category)
    tax_rate = 0.1 # Basic sales tax rate
    tax_rate = 0 if TAX_EXEMPT_CATEGORIES.any? { |exempt_category| category.include?(exempt_category) }
    tax_rate += 0.05 if is_imported
    tax_rate
  end

  def round_up_to_nearest_five_cents(amount)
    (amount / 0.05).ceil * 0.05
  end

  def parse_input(input)
    input.split("\n")
  end

  def calculate_totals(items)
    total_sales_taxes = 0
    total_amount = 0

    items.each do |item|
      quantity, category, price, is_imported = parse_item(item)
      sales_tax = calculate_sales_tax(price, is_imported, category)
      total_price = calculate_total_price(price, sales_tax, quantity)

      total_sales_taxes += sales_tax * quantity
      total_amount += total_price
    end

    [total_sales_taxes, total_amount]
  end

  def prepare_receipt(items)
    receipt_lines = []

    items.each do |item|
      quantity, category, price, is_imported = parse_item(item)
      total_price = calculate_total_price(price, calculate_sales_tax(price, is_imported, category), quantity)
      receipt_lines << format_receipt_entry(quantity, category, total_price)
    end

    receipt_lines
  end

  def calculate_total_price(price, sales_tax, quantity)
    (price + sales_tax) * quantity
  end

  def total_amount_presenter(total_amount)
    "Total: #{format('%.2f', total_amount)}"
  end

  def sales_tax_presenter(total_sales_taxes)
    "Sales Taxes: #{format('%.2f', total_sales_taxes)}"
  end

  def parse_item(item)
    item_details = item.split(' ')
    quantity = item_details[0].to_i
    price = item_details[-1].to_f
    is_imported = item.include?('imported')
    category = item_details[1..-3].join(' ')

    [quantity, category, price, is_imported]
  end

  def format_receipt_entry(quantity, category, total_price)
    format('%<quantity>d %<category>s: %<total_price>.2f', quantity:, category:,
                                                           total_price:)
  end
end
