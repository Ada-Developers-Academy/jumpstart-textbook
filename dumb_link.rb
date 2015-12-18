class String
  def dumb_link #calling this dumb_link because it handles zero edge cases.
    downcase.gsub /\W+/, '-'
  end
end
