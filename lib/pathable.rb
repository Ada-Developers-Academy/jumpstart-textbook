module Pathable
  def breadcrumb_link(site_url, unit, chapter = nil, lecture = nil)
    text = lecture || chapter || unit
    path = uri_builder site_url, unit, chapter, lecture

    [text, path]
  end

  def proxy_path(site_url, unit, chapter = nil, lecture = nil)
    uri_builder(site_url, unit, chapter, lecture) + ".html"
  end

  def markdown_path(root_path, unit, chapter = nil, lecture = nil)
    filepath_builder(root_path, "units", unit, chapter, lecture) + ".md"
  end

  def chapter_directory(root_path, unit, chapter = nil, lecture = nil)
    filepath_builder(root_path, "units", unit, chapter, lecture)
  end

  private

  #calling this dumb_link because it handles zero edge cases.
  def filepath_builder(prefix, *chunks)
    File.join([prefix] + builder(chunks))
  end

  def uri_builder(prefix, *chunks)
    builder(chunks).insert(0, prefix).join('/')
  end

  def builder(chunks = [])
    chunks.compact.map { |chunk| dumb_link chunk }
  end

  def dumb_link(string)
    string.downcase.gsub /\W+/, '-'
  end
end
