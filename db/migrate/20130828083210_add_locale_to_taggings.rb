class AddLocaleToTaggings < ActiveRecord::Migration
  def self.up
    add_column     :taggings, :locale,  :string
    add_index      :taggings,  [:taggable_id, :taggable_type, :locale]
  end

  def self.down
    remove_column  :taggings, :locale
    remove_index   :taggings,  [:taggable_id, :taggable_type, :locale]
  end
end
