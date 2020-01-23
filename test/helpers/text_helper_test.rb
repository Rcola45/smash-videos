class TextHelperTest < ActionView::TestCase
  test 'should return a cleaned filename' do
    assert_nil clean_filename(nil)
    assert_equal '', clean_filename('')
    assert_equal 'bowser_jr.jpg', clean_filename('bowser jr..jpg')
    assert_equal '_BowSer__Jr_2', clean_filename(' BowSer  Jr 2')
    assert_equal '____', clean_filename('. ._ . ')
  end

  test 'should split filename and extension' do
    assert_nil split_extension(nil)
    assert_equal '', split_extension('')
    assert_equal ['filename', ''], split_extension('filename')
    assert_equal ['filename', '.ext'], split_extension('filename.ext')
    assert_equal ['filename.sec', '.ext'], split_extension('filename.sec.ext')
    assert_equal ['filename.', ''], split_extension('filename.')
    assert_equal ['filename', '.y'], split_extension('filename.y')
  end

  test 'should return whether filename contains valid extension' do
    assert_not contains_extension?(nil)
    assert_not contains_extension?('')
    assert_not contains_extension?('filename')
    assert_not contains_extension?('filename.invalidextension')
    assert_not contains_extension?('filename.invalid')
    assert contains_extension?('filename.validd')
    assert contains_extension?('x.py')
  end

  test 'should return extension regex' do
    assert_equal /\.\S{1,6}$/, extension_regex
  end

  test 'should remove bad characters' do
    assert_equal 'ea', transliterate('ea')
    assert_equal 'ea', transliterate('èá')
  end
end
