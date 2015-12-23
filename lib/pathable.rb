module Pathable
  def breadcrumb_link(unit, chapter = nil, lecture = nil, opts = {})
    text = lecture || chapter || unit
    path = builder(site_url, unit, chapter, lecture)

    link_to text, path, opts
  end

  def proxy_path(unit, chapter = nil, lecture = nil)
    builder(site_url, unit, chapter, lecture) + ".html"
  end

  def markdown_path(unit, chapter = nil, lecture = nil)
    builder(root_path, "units", unit, chapter, lecture) + ".md"
  end

  private

  #calling this dumb_link because it handles zero edge cases.
  def dumb_link(string)
    string.downcase.gsub /\W+/, '-'
  end

  def builder(prefix, *chunks)
    File.join([prefix] << chunks.compact.map { |chunk| dumb_link chunk })
  end

  def link_to(*args)
    unless defined?(super)
      raise(NotImplementedError, "Pathable must be mixed into objects that implement a `link_to` method.")
    end
    
    super
  end
end
