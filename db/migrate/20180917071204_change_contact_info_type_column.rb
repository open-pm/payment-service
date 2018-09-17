class ChangeContactInfoTypeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :contact_infos, :type, :contact_type
  end
end
