class Note < ApplicationRecord
  encrypts :body

  # @return [String] markdown first line of note
  def title
    if self.body.empty?
      ""
    else
      self.body.strip.split("\n").first
    end
  end
end
