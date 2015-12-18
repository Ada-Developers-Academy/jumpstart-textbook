require_relative './dumb_link'

# Methods defined in the helpers block are available in templates
helpers do
  def breadcrumb_link(unit, chapter = nil, lecture = nil, opts = {})
    text = lecture || chapter || unit
    path = [site_url, unit, chapter, lecture].compact.map(&:dumb_link).join('/')

    link_to text, path, opts
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
  unit.chapters.each do |chapter|
    chapter.lectures.each do |lecture|
      proxy "/#{  unit.title.dumb_link }/#{  chapter.title.dumb_link }/#{  lecture.dumb_link }.html", "/lecture.html",
      locals: { 
        unit: unit.title,
        chapter: chapter.title,
        lecture: lecture,
        file: "#{root_path}/units/#{ unit.title.dumb_link }/#{  chapter.title.dumb_link }/#{ lecture.dumb_link }.md"
      },
      ignore: true
    end
  end
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :relative_links, true
set :haml, { ugly: true, format: :html5 }
set :markdown_engine, :kramdown
set :site_url, ""

# all environments
activate :directory_indexes
activate :syntax, line_numbers: true
activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
  deploy.remote = 'git@github.com:Ada-Developers-Academy/textbook.git'
  deploy.branch = 'gh-pages'
end

configure :development do
  # Reload the browser automatically whenever files change
  activate :livereload
end

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :relative_assets
  set :site_url, "/textbook"
end

