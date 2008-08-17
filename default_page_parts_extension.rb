class DefaultPagePartsExtension < Radiant::Extension
  version "0.1"
  description "Enables auto-creation of default page parts for a page's children"
  url "http://github.com/santry/radiant-default-page-parts-extension"

  Page.class_eval do
    alias :original_parent_equals :parent=

    def parent=(parent)
      default_parts = parent.render_part('default_child_page_parts').strip.split(/\s*,\s*/)
      default_parts.each do |name|
        self.parts << PagePart.new(:name => name, :filter_id => Radiant::Config['defaults.page.filter'])
      end
      original_parent_equals(parent)
    end
  end

end