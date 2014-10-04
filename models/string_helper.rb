class StringHelper
  def self.titleise(string)
    string.gsub('-', ' ').capitalize
  end

  def self.camelise(string)
    string.gsub('-', ' ').split.map(&:capitalize).join(' ')
  end
end