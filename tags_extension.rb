require_dependency 'application_controller'
require File.dirname(__FILE__)+'/lib/tagging_methods'
require 'radiant-tags-extension'

class TagsExtension < Radiant::Extension
  version RadiantTagsExtension::VERSION
  description "This extension enhances the page model with tagging capabilities, tagging as in \"2.0\" and tagclouds."
  url "https://github.com/jfqd/radiant-tags-extension/"
  
  DEFAULT_RESULTS_URL = '/search/tags'

  def activate
    raise "The Shards extension is required and must be loaded first!" unless defined?(admin.page)
    if Radiant::Config.table_exists?
      Radiant::Config['tags.complex_strings'] = 'true' unless Radiant::Config['tags.complex_strings']
    end
    Page.send :include, MetaTagsTags
    begin
      MetaTag
    rescue
      # dirty hack; need to get trough here to allow migrations to run..
    end
    Page.module_eval &TaggingMethods
    admin.page.edit.add :extended_metadata, 'tag_field'
    
    # HELP
    if admin.respond_to?(:help)
      admin.help.index.add :page_details, 'using_tags', :after => 'breadcrumbs'
    end
  end
  
  def deactivate
  end
end
