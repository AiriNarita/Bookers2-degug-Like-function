class ChangeDatatypeCategoryOfBooks < ActiveRecord::Migration[6.1]
  def change
    change_column :books, :category, :string
  end
end
