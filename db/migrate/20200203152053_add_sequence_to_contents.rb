class AddSequenceToContents < ActiveRecord::Migration[5.2]
  def change
    add_column :contents, :sequence, :integer
  end
end
