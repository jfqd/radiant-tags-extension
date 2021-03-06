class Tagging < ActiveRecord::Base
  belongs_to :meta_tag 
  belongs_to :taggable, :polymorphic => true
  
  def after_initialize
    self.locale = I18n.locale.to_s if self.new_record?
  end
  
  def before_destroy
    # if all the taggings for a particular <%= parent_association_name -%> are deleted, we want to 
    # delete the <%= parent_association_name -%> too
    meta_tag.destroy_without_callbacks if meta_tag.taggings.count < 2 && meta_tag.locale == I18n.locale.to_s # make sure tags with other locales are not deleted!
  end
end