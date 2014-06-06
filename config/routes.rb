ActionController::Routing::Routes.draw do |map|
  begin
    
    if defined?(Globalize2Extension)
      map.localized(I18n.available_locales, :verbose => false) do
        map.localized_tag_search "/:locale/tag/:tag/", :controller => 'site', :action => 'show_page', :url => "/:locale/tag/"
      end
    end
    map.localized(I18n.available_locales, :verbose => false) do
      map.tag_search "/tag/:tag/", :controller => 'site', :action => 'show_page', :url => "/tag/"
    end
    
  rescue
    # dirty hack; need to get trough here to allow migrations to run..
  end
end