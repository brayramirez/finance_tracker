module ApplicationHelper

  def icon name = nil, options = {:text => nil, :class => nil}
    raise 'Icon class required.' if name.blank?

    icon_class = 'material-icons'
    icon_class = [icon_class, options[:class]].join(' ') if options[:class].present?

    html = content_tag :i, name, :class => icon_class
    return html if options[:text].blank?

    html << options[:text]
  end


  def icon_submit_button
    content_tag :button, :type => :submit, :class => 'mdl-button mdl-js-button mdl-button--primary mdl-button--fab mdl-button--mini-fab' do
      self.icon 'check'
    end
  end


  def icon_cancel_button path = '#'
    link_to path, :class => 'mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab' do
      self.icon 'arrow_back'
    end
  end

end
