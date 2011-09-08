require 'maruku'

class Page < ActiveRecord::Base
  
  CONTENT_TYPES = { :markdown => "Markdown", :html => "HTML" }
  
  validates_presence_of :title, :content, :content_type, :url
  
  def publish(page_html_content)
    self.published = true
    if self.save
      File.unlink(file_path) if File.file?(file_path)
      File.open(file_path, 'w') { |file| file.write(page_html_content) }
    end
  end

  def file_path
    "#{Rails.root}/public#{url}"
  end

  def html_content
    if content_type == CONTENT_TYPES[:markdown]
      formatted_content = Maruku.new(content).to_html
    elsif content_type == CONTENT_TYPES[:html]
      formatted_content = content
    end
    return formatted_content
  end
end
