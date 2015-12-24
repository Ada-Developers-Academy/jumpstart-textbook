require 'json'
require 'middleman'
require 'fileutils'
require_relative '../pathable'

desc "Touch into existance all markdown files necessary to support the defined ToC"
task :lectures => :app_instance do
  include Pathable

  directories = []
  markdowns   = []

  # dig through the toc _once_
  # it is gross to nest loops like this; I am so sorry
  toc = JSON::parse File.read(File.join @app.root_path, "data", "toc.json")
  toc.each do |unit|
    # build an array of all directories needed for the chapters in the unit
    unit['chapters'].each do |chapter|
      path = [@app.root_path, unit['title'], chapter['title']]
      directories << chapter_directory(*path)
      markdowns << markdown_path(*path)

      # build an array of md file for all lectures for each chapter in the unit
      chapter['lectures'].each do |lecture|
        markdowns << markdown_path(*(path + [lecture]))
      end
    end
  end

  # make them directories
  FileUtils.makedirs directories

  # touch all the lectures into existence
  markdowns.each { |lecture| `touch #{lecture}` }
end

desc "Noop - creates an instance of the Middleman app for use in other tasks"
task :app_instance do
  @app = ::Middleman::Application.server.inst
end
