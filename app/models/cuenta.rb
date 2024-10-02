class Cuenta < ApplicationRecord
  belongs_to :cliente

  validates :account_number, presence: true, uniqueness: true, numericality: true, length: { is: 16 }
end