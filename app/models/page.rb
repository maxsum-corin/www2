class Page < ActiveRecord::Base
  
  CONTENT_TYPES = { :markdown => "Markdown", :html => "HTML" }
  
  validates_presence_of :title, :content, :content_type, :url
  before_save :publish

  def publish
    published = false if published.nil?
    if published and valid?
      file_path = "#{Rails.root}/public#{url}"
      File.unlink(file_path) if File.file?(file_path)

      if content_type == self::CONTENT_TYPES[:markdown]
        formatted_content = content
      elsif content_type == self::CONTENT_TYPES[:html]
        formatted_content = content
      end

      File.open(file_path, 'w') { |file| file.write(formatted_content) }
    end
  end

  def file_name
    "#{Rails.root}/public#{url}"
  end
end
