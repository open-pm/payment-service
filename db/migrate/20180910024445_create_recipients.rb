class CreateRecipients < ActiveRecord::Migration[5.2]
  def change
    create_table :recipients do |t|
      t.string :remote_id
      t.string :provider_name
      t.references :owner, foreign_key: true

      t.timestamps
    end
  end
end
