# Methods defined in the helpers block are available in templates
def dumb_link(string) #calling this dumb link because it handles 0 edge cases
  string.downcase.gsub(/\W+/, '-')
end

helpers do
  def dumb_link(string) # I'll shave this yak later
    string.downcase.gsub(/\W+/, '-')
  end
end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
data.toc.each do |unit|
  proxy "/#{ dumb_link unit.title }", '/unit.html',
    locals: { title: unit.title, chapters: unit.chapters},
    ignore: true
end

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

set :haml, { ugly: true, format: :html5 }
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :relative_assets
end
