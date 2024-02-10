# frozen_string_literal: true

# InputParser responsible for parsing the input
# and returning an array of items
# items should be an object with the
# following attributes:  quantity, category, price, is_imported
class InputParser
  def self.parse(input)
    @items = input.split("\n")
    items
  end

  def self.items
    @items.map do |item|
      item_details = item.split(' ')
      quantity = item_details[0].to_i
      price = item_details[-1].to_f
      category = item_details[1..-3].join(' ')
      is_imported = item.include?('imported')
      { quantity:, category:, price:, is_imported: }
    end
  end
end
