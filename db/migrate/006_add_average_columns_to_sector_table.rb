class AddAverageColumnsToSectorTable < ActiveRecord::Migration
  def self.up
      add_column :sectors, :eps, :decimal, :precision => 8, :scale => 2
      add_column :sectors, :pe_ratio, :decimal, :precision => 8, :scale => 2
      add_column :sectors, :ronw, :decimal, :precision => 8, :scale => 2
      add_column :sectors, :price_to_book_value_multiple, :decimal, :precision => 8, :scale => 2
  end

  def self.down
      remove_column :sectors, :eps
      remove_column :sectors, :pe_ratio
      remove_column :sectors, :ronw
      remove_column :sectors, :price_to_book_value_multiple
  end
end
