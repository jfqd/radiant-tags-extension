class Tagging < ActiveRecord::Base
  belongs_to :meta_tag 
  belongs_to :taggable, :polymorphic => true
  
  def after_initialize
    self.locale = I18n.locale.to_s if self.new_record?
  end
  
  def before_destroy
    # if all the taggings for a particular <%= parent_association_name -%> are deleted, we want to 
    # delete the <%= parent_association_name -%> too
    if meta_tag.try(:taggings).try(:count).to_i < 2 &&
         meta_tag.locale == I18n.locale.to_s &&
           meta_tag.class_name == self.class.name
      # ensure tags with other locales and class-name are not deleted!
      meta_tag.destroy_without_callbacks
    end
  end
end