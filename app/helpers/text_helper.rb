module TextHelper
  # Cleans filename and returns it
  def clean_filename(filename)
    return filename if filename.nil? || filename.empty?

    fname, extension = split_extension(filename)
    "#{transliterate(fname.gsub(' ', '_').gsub('.', ''))}#{extension.presence}"
  end

  # Removes filename extension from inputted string
  def split_extension(filename)
    return filename if filename.nil? || filename.empty?

    fname, *extension = filename.rpartition('.')

    contains_extension?(filename) ? [fname, extension.join] : [fname + extension.join, '']
  end

  # Check if filename contains an extension
  def contains_extension?(filename)
    return false if filename.nil?

    filename.match(extension_regex)
  end

  # Regex for filename extentions
  def extension_regex
    /\.\S{1,6}$/
  end

  # Removes accents from text
  def transliterate(text)
    I18n.transliterate(text)
  end
end
