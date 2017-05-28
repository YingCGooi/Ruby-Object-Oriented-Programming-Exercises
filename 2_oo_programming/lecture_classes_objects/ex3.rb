# Now create a smart name= method that can take just a first name or a full name, and knows how to set the first_name and last_name appropriately.

class Person
  attr_accessor :last_name, :first_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  private

  def parse_full_name(full_name)
    name_split = full_name.split
    self.first_name = name_split.first
    self.last_name = name_split.size > 1 ? name_split.last : ''
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
p bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

p bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'