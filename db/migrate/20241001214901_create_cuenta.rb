class CreateCuenta < ActiveRecord::Migration[7.2]
  def change
    create_table :cuenta do |t|
      t.string :account_number
      t.references :cliente, null: false, foreign_key: true

      t.timestamps
    end
  end
end
