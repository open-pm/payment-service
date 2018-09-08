class CreateContactInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_infos do |t|
      t.string :type
      t.string :info
      t.references :owner, foreign_key: true

      t.timestamps
    end
  end
end
