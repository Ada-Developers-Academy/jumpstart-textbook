require 'json'
require 'middleman'
require 'fileutils'
require_relative '../pathable'

desc "Touch into existance all markdown files necessary to support the defined ToC"
task :lectures => :app_instance do
  include Pathable

  # dig through the toc _once_
  # it is gross to nest loops like this; I am so sorry
  toc = JSON::parse File.read(File.join @app.root_path, "data", "toc.json")
  toc.each do |unit|
    # build an array of all directories needed for the chapters in the unit
    cds = unit['chapters'].map do |chapter|
      chapter_directory @app.root_path, unit['title'], chapter['title']
    end

    # make them directories
    FileUtils.makedirs cds

    # build an array of md file for all lectures for each chapter in the unit
    lectures = []
    unit['chapters'].each do |chapter|
      lectures << chapter['lectures'].map do |lecture|
        markdown_path @app.root_path, unit['title'], chapter['title'], lecture
      end
    end

    # touch all the lectures into existence
    lectures.flatten.each { |lecture| `touch #{lecture}` }
  end
end

desc "Noop - creates an instance of the Middleman app for use in other tasks"
task :app_instance do
  @app = ::Middleman::Application.server.inst
end
