class AddAttributeToSectorTable < ActiveRecord::Migration
  def self.up
      add_column :sectors, :name, :string, :null => false
      add_column :sectors, :outlook, :string
      add_column :sectors, :child_url, :string
  end

  def self.down
      remove_column :sectors, :name
      remove_column :sectors, :outlook
      remove_column :sectors, :child_url
  end
end
