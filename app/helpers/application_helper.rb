module ApplicationHelper
  MARKDOWN = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true, strikethrough: true, superscript: true)

  def markdown(s)
    sanitize MARKDOWN.render(s)
  end
end
