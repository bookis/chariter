class Commitment < ActiveRecord::Base
  
  validates :amount, :organization_url, :presence => true
  belongs_to :user
  has_many :tasks
  accepts_nested_attributes_for :tasks, :allow_destroy => true
  
  
  composed_of :amount,
    :class_name => "Money",
    :mapping => [%w(amount_in_cents cents), %w(currency currency_as_string)],
    :constructor => Proc.new { |cents, currency| Money.new(cents || 0, Money.default_currency) },
    :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }

  composed_of :credit,
    :class_name => "Money",
    :mapping => [%w(credit_in_cents cents), %w(currency currency_as_string)],
    :constructor => Proc.new { |cents, currency| Money.new(cents || 0, Money.default_currency) },
    :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }
  
end
