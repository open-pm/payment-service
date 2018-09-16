class CreateBankAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_accounts do |t|
      t.string :account_number
      t.string :account_digit
      t.integer :bank_code
      t.string :branch_number
      t.string :branch_digit
      t.references :recipient, foreign_key: true

      t.timestamps
    end
  end
end
