class ChangeDocumentTypeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :documents, :type, :document_type
  end
end
