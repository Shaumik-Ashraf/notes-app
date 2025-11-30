module ApplicationHelper
  MARKDOWN = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true, strikethrough: true, superscript: true)
  TIME_FORMAT = "%r %x"
  
  # @param s [String]
  def markdown(s)
    sanitize MARKDOWN.render(s)
  end

  # @param d [DateTime, #to_datetime, nil]
  # @return [String]
  # @raises [StandardError]
  def time_format(d)
    if d.nil?
      "N/A"
    elsif d.is_a? DateTime
      d.strftime(TIME_FORMAT)
    elsif d.respond_to? :to_datetime
      time_format(d.to_datetime)
    else
      raise StandardError, "Cannot convert #{d} into time format"
    end
  end
end
