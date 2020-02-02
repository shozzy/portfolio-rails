class AddWhenToContents < ActiveRecord::Migration[5.2]
  def change
    add_column :contents, :when, :string
  end
end
