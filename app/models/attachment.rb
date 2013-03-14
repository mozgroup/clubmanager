class Attachment < ActiveRecord::Base
  attr_accessible :attachable_id, :attachable_type, :item

  belongs_to :attachable, polymorphic: true
  mount_uploader :item, ItemUploader

  def filename
    File.basename(item.path || item.filename) if item
  end

  def image
    case
    when item.file.content_type.match(/pdf/)
      'file-pdf'
    when item.file.content_type.match(/excel|spreadsheet/)
      'file-excel'
    when item.file.content_type.match(/msword|document/)
      'file-word'
    else
      'file-image'
    end
  end
end
