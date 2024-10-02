class CreateClientes < ActiveRecord::Migration[7.2]
  def change
    create_table :clientes do |t|
      t.string :first_name
      t.string :last_name_paternal
      t.string :last_name_maternal
      t.string :email
      t.integer :age
      t.string :gender
      t.string :curp
      t.date :date_of_birth

      t.timestamps
    end
  end
end
