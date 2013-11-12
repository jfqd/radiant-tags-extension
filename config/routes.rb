ActionController::Routing::Routes.draw do |map|
  begin
    
    if defined?(Globalize2Extension)
      # I18n.available_locales == [:ru, :en, :it, :nl, :pl, :fr, :de, :ja, :ro, :es]
      map.localized(I18n.available_locales, :verbose => false) do
        map.localized_category_search "/:locale/category/:tag/", :controller => 'site',   :action => 'show_page'
      end
    end
    map.category_search "/category/:tag/", :controller => 'site',   :action => 'show_page'
    
  rescue
    # dirty hack; need to get trough here to allow migrations to run..
  end
end