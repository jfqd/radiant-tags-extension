class UpdateIndexes < ActiveRecord::Migration
  def self.up
    remove_index :meta_tags, :name
    add_index    :meta_tags, [:name, :locale, :site_id]
    add_index    :meta_tags, [:site_id, :locale]
  end

  def self.down
    add_index    :meta_tags, :name, :unique => true
    remove_index :meta_tags, [:name, :locale, :site_id]
    remove_index :meta_tags, [:site_id, :locale]
  end
end
