# frozen_string_literal: true

# Sales tax calculator class
class SalesTaxCalculator
  # item categories exempt from basic sales tax
  TAX_EXEMPT_CATEGORIES = %w[book chocolate pills].freeze

  # Function to calculate sales tax for an item
  def calculate_sales_tax(price, is_imported, category)
    tax_rate = 0.1 # Basic sales tax rate

    # If the item falls under exempt categories, no tax is applied
    tax_rate = 0 if TAX_EXEMPT_CATEGORIES.any? { |exempt_category| category.include?(exempt_category) }

    # Check if the item is imported and add additional tax
    tax_rate += 0.05 if is_imported

    # Calculate sales tax and round up to the nearest 0.05
    (price * tax_rate / 0.05).ceil * 0.05
  end

  # Function to parse input and generate receipt
  def generate_receipt(input) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    items = input.split("\n")
    total_sales_taxes = 0
    total_amount = 0
    receipt = items.map do |item|
      quantity, category, price, is_imported = parse_item(item)
      sales_tax = calculate_sales_tax(price, is_imported, category)
      total_sales_taxes += sales_tax * quantity
      total_price = (price + sales_tax) * quantity
      total_amount += total_price
      format_receipt_entry(quantity, category, total_price)
    end.join("\n ")
    [receipt, sales_tax_presenter(total_sales_taxes), total_amount_presenter(total_amount)]
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
    format('%d %s: %.2f', quantity, category, total_price)
  end
end
