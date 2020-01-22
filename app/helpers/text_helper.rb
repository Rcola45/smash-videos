module TextHelper
  def clean_filename(text)
    return text if text.empty?

    transliterate(remove_extension(text.gsub(/[ \.]/, ' ': '_', '.': '')))
  end

  def contains_extension?(filename)
    filename.match(extension_regex)
  end

  def remove_extension(filename)
    filename.gsub(extension_regex, '')
  end

  def extension_regex
    /\.\s{1,6}$/
  end

  def transliterate(text)
    I18n.transliterate(text)
  end
end
