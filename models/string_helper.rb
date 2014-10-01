class StringHelper
  def self.titlelise(string)
    string.gsub('-', ' ').capitalize
  end
end