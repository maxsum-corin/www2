require 'maruku'

class Page
  
  include DataMapper::Resource

  CONTENT_TYPES = { :markdown => "Markdown", :html => "HTML" }

  property :id,           Serial
  property :title,        String, :required => true
  property :content,      String, :required => true # TODO: Text(?) Blob(?)
  property :content_type, String, :required => true # TODO: Enum
  property :url,          String, :required => true, :format => /^[\w\/]+\.html?$/,
                                  :messages => {
                                    :presence => "Please specifiy a URL",
                                    :format   => "URL must end with .html or .htm"
                                  }
  property :published,    Boolean
  
  #validates :content_type, :inclusion => { :in => CONTENT_TYPES.values, :message => "%{value} is not a valid content_type" }
  before :save, :sanitize_url

  def sanitize_url
    first_char = url[0,1]
    self.url = "/#{url}" unless first_char == "/"
  end
  
  def publish(page_html_content)
    self.published = true
    if self.save
      if File.file?(file_path)
        File.unlink(file_path)
      else
        create_directories
      end
      File.open(file_path, 'w') { |file| file.write(page_html_content) }
    end
  end

  def unpublish
    self.published = false
    if self.save and File.file?(file_path)
      File.unlink(file_path)
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

  def create_directories
    base_directory = File.dirname(file_path)
    created = File.directory?(base_directory)
    hierarchy = Array.new
    until created
      hierarchy << base_directory
      base_directory = File.dirname(base_directory)
      created = File.directory?(base_directory)
    end
    hierarchy.reverse.each do |dir|
      Dir.mkdir(dir)
    end
  end
end
