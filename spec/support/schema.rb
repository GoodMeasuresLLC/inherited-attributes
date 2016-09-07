ActiveRecord::Schema.define do
  self.verbose = false

  create_table :organizations, :force => true do |t|
    t.string :name

    t.string  :string_attribute
    t.string  :string_attribute_with_default

    t.integer :integer_attribute
    t.integer :integer_attribute_with_default

    t.float :float_attribute
    t.float :float_attribute_with_default

    t.integer :enumeration_attribute
    t.integer :enumeration_attribute_with_default

    t.boolean :boolean_attribute
    t.boolean :boolean_attribute_with_false_default
    t.boolean :boolean_attribute_with_true_default

    t.string :ancestry, :index => true
  end
end
