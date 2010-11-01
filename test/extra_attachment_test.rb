require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class CSVAttachmentTest < ActiveSupport::TestCase
  attachment_model SmallAttachment

  # should deal with blank content_type from safari issues
  def test_should_create_file_from_uploaded_csv_from_safari
    assert_created do
      attachment = upload_file :filename => '/files/foo.csv', :content_type => ""
      assert_equal "text/csv", attachment.content_type
      assert_valid attachment
    end
  end  
end

class OrphanAttachmentTest < ActiveSupport::TestCase
  include BaseAttachmentTests
  attachment_model OrphanAttachment
  
  def test_should_create_image_from_uploaded_file
    assert_created do
      attachment = upload_file :filename => '/files/rails.png'
      assert_valid attachment
      assert !attachment.db_file.new_record? if attachment.respond_to?(:db_file)
      assert  attachment.image?
      assert !attachment.size.zero?
    end
  end
  
  def test_should_create_file_from_uploaded_file
    assert_created do
      attachment = upload_file :filename => '/files/foo.txt'
      assert_valid attachment
      assert !attachment.db_file.new_record? if attachment.respond_to?(:db_file)
      assert  attachment.image?
      assert !attachment.size.zero?
    end
  end
  
  def test_should_create_file_from_merb_temp_file
    assert_created do
      attachment = upload_merb_file :filename => '/files/foo.txt'
      assert_valid attachment
      assert !attachment.db_file.new_record? if attachment.respond_to?(:db_file)
      assert  attachment.image?
      assert !attachment.size.zero?
    end
  end
  
  def test_should_create_image_from_uploaded_file_with_custom_content_type
    assert_created do
      attachment = upload_file :content_type => 'foo/bar', :filename => '/files/rails.png'
      assert_valid attachment
      assert !attachment.image?
      assert !attachment.db_file.new_record? if attachment.respond_to?(:db_file)
      assert !attachment.size.zero?
      #assert_equal 1784, attachment.size
    end
  end
  
  def test_should_create_thumbnail
    attachment = upload_file :filename => '/files/rails.png'
    
    assert_raise Technoweenie::AttachmentFu::ThumbnailError do
      attachment.create_or_update_thumbnail(attachment.create_temp_file, 'thumb', 50, 50)
    end
  end
  
  def test_should_create_thumbnail_with_geometry_string
   attachment = upload_file :filename => '/files/rails.png'
    
    assert_raise Technoweenie::AttachmentFu::ThumbnailError do
      attachment.create_or_update_thumbnail(attachment.create_temp_file, 'thumb', 'x50')
    end
  end
end

class MinimalAttachmentTest < OrphanAttachmentTest
  attachment_model MinimalAttachment

  def test_should_be_able_to_set_a_random_attribute
    attachment = attachment_model.new(:spare_data => "test")
    assert_equal "test", attachment.spare_data
  end

end