# frozen_string_literal: true

module ApplicationHelper
  def file_uploader(f, method, _file_style = 'original', options = { remove: false, size: '395x' })
    return '' unless f.object.respond_to?(method)

    tag.div class: 'file-upload' do
      if f.object.send(method).send('attached?')
        file_purge_field(f, method, options)
        remove_text(options)
      end
      concat(f.file_field(method.to_sym))
      if options[:width] || options[:height]
        string << "<span class=\"instructions\">Best size: #{options[:width] || 'any'} W x #{options[:height] || 'any'} H</span>"
      end
      concat(tag.br)
      concat(tag.output(class: 'thumbnails-preview'))
    end
  end

  def file_purge_field(f, method, options)
    if f.object.send(method).blob.content_type.starts_with?('image/')
      concat image_tag(url_for(f.object.send(method).variant(resize: options[:size])))
    else
      concat link_to(File.basename(url_for(f.object.send(method))), url_for(f.object.send(method)))
    end
    concat tag.br
    concat check_box_tag('purge')
    concat label_tag('purge', "Remove #{method.to_s.titleize}")
    concat tag.br
  end

  def remove_text(options)
    span = if options[:remove]
             tag.span 'Choose a new file:'
           else
             tag.span 'Or choose a new file:'
           end
    span + tag.br
  end

  def error_messages_for(object)
    render(partial: 'application/error_messages', locals: { object: object })
  end

  def truncate_on_space(text, *args)
    options = args.extract_options!
    options.reverse_merge!(length: 30, omission: '...')
    return text if text.blank? || text.size <= options[:length]

    new_text = truncate(text, length: options[:length] + 1, omission: '')
    return new_text + options[:omission] if last == ' ' while last == new_text.slice!(-1, 1)
  end

  def status_tag(boolean, options = {})
    options[:truthy] ||= ''
    options[:true_class] ||= 'status true oi oi-circle-check icon-green'
    options[:falsey] ||= ''
    options[:false_class] ||= 'status false oi oi-circle-x icon-red'

    if boolean
      content_tag(:span, options[:truthy], class: options[:true_class])
    else
      content_tag(:span, options[:falsey], class: options[:false_class])
    end
  end

  def menu_link(title, path)
    controller_path = path.sub('/', '')
    link_to(title, path, class: 'btn btn-primary btn-block menu-link')
  end

  def nav_link(display, path, controller, options = { method: :get, class: '' })
    controller_path = path.sub('/', '')
    link_current = controller_name == controller ? content_tag(:span, '(current)', class: 'sr-only') : ''
    content_tag(:li, class: "nav-item #{'active' if controller_name == controller} #{options[:class]}") do
      link_to  (display + link_current).html_safe, path, class: 'nav-link', method: options[:method]
    end
  end

  def cancel_button(link)
    "<input type='button' value='Cancel' class='cancel-button' onclick=\"window.location.href='#{link}';\" />".html_safe
  end

  def title(page_title)
    content_for(:title) { page_title }
  end
end
