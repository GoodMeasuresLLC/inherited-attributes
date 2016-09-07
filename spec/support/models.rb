
class Account < ActiveRecord::Base
  belongs_to :node
end

class Node < ActiveRecord::Base
  STRING_DEFAULT = '"United States"'
  ENUMERATION_DEFAULT = '"english"'
  INTEGER_DEFAULT = '18'
  FLOAT_DEFAULT = '3.14159'

  has_ancestry

  has_one :account
  delegate :name, :to => :account, :prefix => true, :allow_nil => true
  delegate :name, :to => :effective_account, :prefix => true, :allow_nil => true
  delegate :name, :to => :inherited_account, :prefix => true, :allow_nil => true

  def account_name=(val)
    (self.account || self.build_account).name = val
  end

  enum :enumeration_attribute => {
    :ruby => 1,
    :java => 2,
    :javascript => 3,
    :php => 4
  }

  enum :enumeration_attribute_with_default => {
    :english => 1,
    :spanish => 2,
    :german => 3,
    :madarin => 4
  }

  inherited_attribute  :string_attribute
  inherited_attribute  :string_attribute_with_default, :default => STRING_DEFAULT

  inherited_attribute :integer_attribute
  inherited_attribute :integer_attribute_with_default, :default => INTEGER_DEFAULT

  inherited_attribute :float_attribute
  inherited_attribute :float_attribute_with_default, :default => FLOAT_DEFAULT

  inherited_attribute :enumeration_attribute
  inherited_attribute :enumeration_attribute_with_default, :default => ENUMERATION_DEFAULT

  inherited_attribute :boolean_attribute
  inherited_attribute :boolean_attribute_with_false_default, :default => 'false'
  inherited_attribute :boolean_attribute_with_true_default, :default => 'true'

  inherited_attribute :account
end
