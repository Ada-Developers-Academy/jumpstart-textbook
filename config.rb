# site structure variables
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :relative_links, true
set :haml, { ugly: true, format: :html5 }
set :markdown_engine, :kramdown
set :site_url, ""

# bring the link building module into scope
require_relative './lib/pathable'
class Middleman::Application
  include Pathable
end

# Methods defined in the helpers block are available in templates
helpers do
  # helpers need crumb/path building too
  include Pathable
end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
data.toc.each do |unit|
  # make a proxy for each unit
  proxy proxy_path(site_url, unit.title), "/unit.html",
    locals: {
      unit: unit,
      file: markdown_path(root_path, unit.title)
    },
    ignore: true
  
  unit.chapters.each do |chapter|
    # make a proxy for each chapter in the unit
    proxy proxy_path(site_url, unit.title, chapter.title), "/chapter.html",
      locals: {
        unit: unit.title,
        chapter: chapter.title,
        lectures: chapter.lectures,
        file: markdown_path(root_path, unit.title, chapter.title)
      },
      ignore: true

    # make a proxy for every lecture in the chapter
    chapter.lectures.each do |lecture|
      proxy proxy_path(site_url, unit.title, chapter.title, lecture), "/lecture.html",
        locals: { 
          unit: unit.title,
          chapter: chapter.title,
          lecture: lecture,
          file: markdown_path(root_path, unit.title, chapter.title, lecture)
        },
        ignore: true
    end
  end
end

# all environments
activate :directory_indexes
activate :syntax, line_numbers: true
activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
  deploy.remote = 'git@github.com:Ada-Developers-Academy/jumpstart-textbook.git'
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
  set :site_url, "/jumpstart-textbook"
end

