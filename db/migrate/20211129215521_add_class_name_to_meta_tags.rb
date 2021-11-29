class AddClassNameeToMetaTags < ActiveRecord::Migration
  def self.up
    add_column     :meta_tags, :class_name,  :string
    
    begin
      MetaTag.all.each do |mt|
        mt.class_name = "Page"
        mt.save(false)
      end
    rescue
    end
  end

  def self.down
    remove_column  :meta_tags, :class_name
  end
end
