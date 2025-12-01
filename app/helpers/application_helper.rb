module ApplicationHelper
  MARKDOWN = Redcarpet::Markdown.new(
    Redcarpet::Render::HTML.new(
      filter_html: true,
      no_images: false,
      no_links: false,
      safe_links_only: true,
      hard_wrap: true
    ),
    autolink: true,
    tables: true,
    strikethrough: true,
    superscript: true,
    no_intra_emphasis: true,
    fenced_code_blocks: true
  )
  TIME_FORMAT = "%r %x"

  # @param s [String]
  def markdown(s)
    sanitize(
      MARKDOWN.render(s),
      tags: %w[p br strong em ul ol li h1 h2 h3 h4 h5 h6 code pre blockquote table thead tbody tr th td a hr],
      attributes: { "a" => [ "href" ] }
    )
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
