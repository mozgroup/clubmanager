class Attachment < ActiveRecord::Base
  attr_accessible :attachable_id, :attachable_type, :item

  belongs_to :attachable, polymorphic: true
  mount_uploader :item, ItemUploader

  def filename
    File.basename(item.path || item.filename) if item
  end

  def image
    if is_spreadsheet?
      'file-excel'
    elsif is_pdf?
      'file-pdf'
    elsif is_document?
      'file-word'
    elsif is_database?
      'file-access'
    elsif is_jpg?
      'file-jpg'
    elsif is_png?
      'file-png'
    elsif is_powerpoint?
      'file-powerpoint'
    else
      'file-default'
    end
  end

  def is_spreadsheet?
    item_match /xls|xlsx|xlt|ods/
  end

  def is_pdf?
    item_match /pdf/
  end

  def is_document?
    item_match /doc|docx|odt/
  end

  def is_powerpoint?
    item_match /ppt|pptx|odp|pps|ppsx|pot|potm/
  end

  def is_database?
    item_match /odb|db/
  end

  def is_gif?
    item_match /gif/
  end

  def is_jpg?
    item_match /jpg/
  end

  def is_png?
    item_match /png/
  end

  private

    def item_match(regex)
      item.to_s.match regex
    end
end
