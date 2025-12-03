class Note < ApplicationRecord
  encrypts :body

  validates :body, presence: true, length: { maximum: 1_000_000_000 }

  README = File.read(Rails.root.join("README.md"))

  # @return [String] cached README markdown text
  def self.readme
    README
  end

  # @return [String] markdown first line of note
  def title
    return "" if body.blank?
    body.strip.split("\n").first
  end
end
