module TextHelper
  # Cleans filename and returns it with
  def clean_filename(filename)
    return text if filename.empty?

    fname, extension = split_extension(filename)
    "#{transliterate(fname.gsub(' ', '_').gsub('.', ''))}#{extension.presence}"
  end

  # Removes filename extension from inputted string
  def split_extension(filename)
    fname, *extension = filename.rpartition('.')
    [fname, extension.join]
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
