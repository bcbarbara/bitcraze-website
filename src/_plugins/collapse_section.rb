module Jekyll

  # Use this tag to create a collapsed section with a link to open it
  #
  # Example:
  # {% collapse_section My title %}
  # Some content that is collapsed (supports markdown)
  # {% endcollapse_section %}

  class CollapseSection < Liquid::Block
    @@id = 1

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      opening_tags = '<div><a href="#CollapseSection%1$s" data-toggle="collapse"><strong>%2$s</strong></a><div id="CollapseSection%1$s" class="collapse">' % [@@id, @text]
      markup = markdownify(super, context)
      closing_tags = '</div></div>'

      @@id += 1

      "#{opening_tags}#{markup}#{closing_tags}"
    end

    def markdownify(md, context)
      site = context.registers[:site]
      converter = site.find_converter_instance(Jekyll::Converters::Markdown)
      converter.convert(md)
    end

    def self.reset_id_counter()
      @@id = 1
    end
  end
end

Liquid::Template.register_tag('collapse_section', Jekyll::CollapseSection)