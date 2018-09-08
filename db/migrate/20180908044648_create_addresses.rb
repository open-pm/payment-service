class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :street
      t.integer :number
      t.string :zip_code
      t.string :complement
      t.references :owner, foreign_key: true

      t.timestamps
    end
  end
end
