class VhostCompatibility < ActiveRecord::Migration
  def self.up
    add_column  :meta_tags, :site_id,         :integer
  end

  def self.down
    remove_column  :meta_tags, :site_id,         :integer
  end
end
