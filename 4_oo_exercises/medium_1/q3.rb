# In the last question Alyssa showed Alan this code which keeps track of items for a shopping cart application:

class InvoiceEntry
  attr_accessor :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    self.quantity = updated_count if updated_count >= 0
  end
end

new_invoice = InvoiceEntry.new('orange', 4)
p new_invoice.update_quantity(6)
p new_invoice
p new_invoice.quantity = 99
p new_invoice

# Alan noticed that this will fail when update_quantity is called. Since quantity is an instance variable, it must be accessed with the @quantity notation when setting it. One way to fix this is to change attr_reader to attr_accessor and change quantity to self.quantity.

# Is there anything wrong with fixing it this way?

# It is syntatically correct. However, the public interface is altered.
# Clients of the class can now change the quantity directly, rather than by going through the update_quantity method.
# This can be done by just calling the setter method within an instance of InvoiceEntry directly instead of calling the update quantity_instance method.
# protections built into the #update_quantity instance method can be ignored.


