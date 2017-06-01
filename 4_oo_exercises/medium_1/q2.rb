# Alyssa created the following code to keep track of items for a shopping cart application she's writing:

class InvoiceEntry
  attr_accessor :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0
  end
end

p new_invoice = InvoiceEntry.new('orange', 4)
p new_invoice.update_quantity(6)
p new_invoice.instance_variable_get(:@quantity)

# In this class we only defined a getter method for @quantity through attr_reader. If we need to reassign @quantity to another value, we need to have a setter method defined within the class.

# This can be done through specifying a attr_accessor or a setter method for @quantity, or directly referencing @quantity within the method body of update_quantity.