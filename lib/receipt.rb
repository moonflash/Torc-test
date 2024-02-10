# frozen_string_literal: true

# receipt
# responsible for presenting the receipt
# accepts an array of receipt items, total sales taxes, and total amount
class Receipt
  def initialize(receipt_items, total_sales_taxes, total_amount)
    @receipt_items = receipt_items
    @total_sales_taxes = total_sales_taxes
    @total_amount = total_amount
  end

  def print
    lines = []
    @receipt_items.each do |receipt_line|
      lines << format_receipt_entry(receipt_line[0], receipt_line[1], receipt_line[2])
    end
    lines.join("\n")
    [lines.join("\n"), sales_tax_presenter, total_amount_presenter]
  end

  def total_amount_presenter
    "Total: #{format('%.2f', @total_amount)}"
  end

  def sales_tax_presenter
    "Sales Taxes: #{format('%.2f', @total_sales_taxes)}"
  end

  def format_receipt_entry(quantity, category, total_price)
    format('%<quantity>d %<category>s: %<total_price>.2f', quantity:, category:,
                                                           total_price:)
  end
end
