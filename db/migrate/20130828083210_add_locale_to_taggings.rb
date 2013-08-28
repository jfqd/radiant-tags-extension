class AddLocaleToTaggings < ActiveRecord::Migration
  def self.up
    add_column     :taggings, :locale,  :string
  end

  def self.down
    remove_column  :taggings, :locale,  :string
  end
end
