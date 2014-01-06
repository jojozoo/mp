require 'will_paginate/view_helpers/link_renderer'
require 'will_paginate/view_helpers/action_view'
module WillPaginate
  module ActionView
    def will_paginate(collection = nil, options = {})
      options[:renderer] ||= BootstrapLinkRenderer
      super.try :html_safe
    end
 
    class BootstrapLinkRenderer < LinkRenderer
      protected
      
      def html_container(html)
        tag :ul, html, container_attributes
      end
      def gap
        text = @template.will_paginate_translate(:page_gap) { '&hellip;' }
        %(<li class="disabled"><span>#{text}</span></li>)
        # %(<li class="disabled"><a href="#">#{text}</a></li>)
      end
 
      def page_number(page)
        if page == current_page
          tag :li, (tag :span, page, rel: rel_value(page)), :class => 'active'
        else
          tag :li, link(page, page, :rel => rel_value(page))
        end
      end
 
      def previous_or_next_page(page, text, classname)
        if page
          tag :li, link(text, page), class: classname
        else
          tag :li, tag(:span, text), class: [classname, 'disabled'].join(' ')
        end
      end

    end
  end
end