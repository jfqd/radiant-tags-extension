# encoding: utf-8
class MetaTag < ActiveRecord::Base

  if Radiant::Config['tags.complex_strings'] == 'true'
    delim = ";"
    re_format = /^[[:alpha:]0-9äöüÄÖÜß,\_\-\s\/()'.&]+$/
  else
    delim = " "
    re_format = /^[[:alpha:]0-9äöüÄÖÜß\_\-]+$/
  end
  DELIMITER = delim
    # how to separate tags in strings (you may
    # also need to change the validates_format_of parameters 
    # if you update this)

  # if speed becomes an issue, you could remove these validations 
  # and rescue the AR index errors instead
  validates_presence_of   :name
  validates_uniqueness_of :name, :scope => [:locale, :site_id], :case_sensitive => false
  validates_format_of     :name, :with => re_format, 
                          :message => "can not contain special characters"
  
  begin
    if defined?(PaperclippedExtension)
      has_many_polymorphs :taggables,
        :from => [:pages, :assets],
        :through => :taggings,
        :dependent => :destroy,
        :skip_duplicates => false
    else
      has_many_polymorphs :taggables,
        :from => [:pages],
        :through => :taggings,
        :dependent => :destroy,
        :skip_duplicates => false
    end
  rescue
    # ugly hack to get migrations pass
  end
  
  named_scope :with_locale, lambda { { conditions: { locale: I18n.locale.to_s} } }
  named_scope :and_class_name, lambda{ |class_name| { conditions: ["class_name = ?", class_name] } }
  
  def after_save
    # if you allow editable tag names, you might want before_save instead 
    self.name = name.downcase.strip.squeeze(" ")
  end
 
  class << self
    def find_or_create_by_name!(name)
      find_by_name_and_locale(name, I18n.locale.to_s) || create!(name: name, locale: I18n.locale.to_s)
    end

    def cloud(options = {})
      options = {by: 'popularity', order: 'asc', limit: 5}.merge(options)
      validate_by options[:by]
      validate_order options[:order]
      all(
        :select => 'meta_tags.*, count(*) as popularity',
        :limit => options[:limit],
        :joins => "JOIN taggings ON taggings.meta_tag_id = meta_tags.id",
        :conditions => options[:conditions],
        :group => "meta_tags.id, meta_tags.name",
        :order => "#{options[:by]} #{options[:order].upcase}"
      )
    end
    
    def validate_by(by)
      valid_field_names = column_names + ['popularity']
      valid_field_names.include?(by) or raise %Q{"by" must be one of #{valid_field_names.to_sentence}, was #{by}}
    end
    
    def validate_order(order)
      order =~ /^(asc|desc)$/i or raise %Q{"order" must be set to either "asc" or "desc"}
    end
  end
  
  def <=>(other)
    # To be able to sort an array of tags
    name <=> other.name
  end

end
