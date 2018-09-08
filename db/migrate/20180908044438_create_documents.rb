class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :number
      t.string :type
      t.references :owner, foreign_key: true
      t.timestamps
    end
  end
end
