class AddForeignKeyToCompanyTable < ActiveRecord::Migration
  def self.up
      add_column :companies, :sector_id, :integer, :null => false
  end

  def self.down
      remove_column :companies, :sector_id
  end
end
