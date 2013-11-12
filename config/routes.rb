ActionController::Routing::Routes.draw do |map|
  begin
    
    if defined?(Globalize2Extension)
      map.localized_category_search "/:locale/tag/:tag/",
                                    :controller => 'site',
                                    :action => 'show_page',
                                    :url => "/:locale/tag/"
    end
    map.category_search "/tag/:tag/",
                        :controller => 'site',
                        :action => 'show_page',
                        :url => "/tag/"
    
  rescue
    # dirty hack; need to get trough here to allow migrations to run..
  end
end