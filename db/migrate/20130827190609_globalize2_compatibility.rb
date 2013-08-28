class Globalize2Compatibility < ActiveRecord::Migration
  def self.up
    add_column  :meta_tags, :locale,  :string
  end

  def self.down
    remove_column  :meta_tags, :locale
  end
end
