class UpdateIndexes < ActiveRecord::Migration
  def self.up
    remove_index :meta_tags, :name
    add_index    :meta_tags, [:name, :locale, :site_id]
    add_index    :meta_tags, [:site_id, :locale]
    add_index    :taggings,  [:taggable_id, :taggable_type, :locale]
  end

  def self.down
    add_index    :meta_tags, :name, :unique => true
    remove_index :meta_tags, [:name, :locale, :site_id]
    remove_index :meta_tags, [:site_id, :locale]
    remove_index :taggings,  [:taggable_id, :taggable_type, :locale]
  end
end
