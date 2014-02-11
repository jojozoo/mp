inputs = %w[
  CollectionSelectInput
  FileInput
  GroupedCollectionSelectInput
  NumericInput
  PasswordInput
  RangeInput
  StringInput
  TextInput
]
# DateTimeInput
inputs.each do |input_type|
  superclass = "SimpleForm::Inputs::#{input_type}".constantize
 
  new_class = Class.new(superclass) do
    def input_html_classes
      super.push('form-control')
    end
  end
 
  Object.const_set(input_type, new_class)
end
# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.wrappers :bootstrap, :tag => 'div', class: 'form-group', :error_class => 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper :tag => 'div', :class => 'col-sm-6 input-text-add' do |ba|
      ba.use :input
      # ba.use :error, :wrap_with => { :tag => 'span', :class => 'help-inline' }
      ba.use :hint,  :wrap_with => { :tag => 'p', :class => 'help-block' }
    end
    b.use :error, :wrap_with => { :tag => 'span', :class => 'form-error-tip col-sm-4' }
  end

  config.wrappers :date, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: 'div', class: 'input-text-add' do |input|
      input.wrapper tag: 'div', class: 'col-sm-2' do |date|
        date.use :input
      end
      input.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
    b.use :error, :wrap_with => { :tag => 'span', :class => 'form-error-tip col-sm-4' }
  end
 
  config.wrappers :append, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.wrapper tag: 'div', class: 'controls' do |input|
      input.wrapper tag: 'div', class: 'input-group' do |prepend|
        prepend.use :input
        prepend.use :label , class: 'input-group-add' ###Please note setting class here fro the label does not currently work (let me know if you know a workaround as this is the final hurdle)
      end
      input.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
      input.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
    end
  end

  # Wrappers for forms and inputs using the Twitter Bootstrap toolkit.
  # Check the Bootstrap docs (http://twitter.github.com/bootstrap)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  config.default_wrapper = :bootstrap
end



# datepicker
class DatepickerInput < SimpleForm::Inputs::StringInput
  def input
    # datetimepicker http://eonasdan.github.io/bootstrap-datetimepicker/ 
    # 也可以          http://www.bootcss.com/p/bootstrap-datetimepicker/
    # icon           http://www.bootcss.com/p/font-awesome/
    value  = object.send(attribute_name) if object.respond_to? attribute_name
    # 默认格式
    picker = {
      type: :date,
      ddformat: I18n.t('datepicker.dformat', :default => '%Y-%m-%d'),
      dtformat: I18n.t('timepicker.dformat', :default => '%R'),
      pdformat: I18n.t('datepicker.pformat', :default => 'dd/MM/yyyy'),
      ptformat: I18n.t('timepicker.pformat', :default => 'hh:mm'),
      icon: 'calendar',
      isremove: true,
      language: I18n.locale.to_s
    }.merge(input_options.delete(:picker) || {})

    ddformat = picker.delete(:ddformat)
    dtformat = picker.delete(:dtformat)
    pdformat = picker.delete(:pdformat)
    ptformat = picker.delete(:ptformat)

    dp, pp, icon = case picker.delete(:type)
    when :date
      [ddformat, pdformat, 'calendar']
    when :time
      [dtformat, ptformat, 'time']
    else
      [ddformat + ' ' + dtformat, pdformat + ' ' + ptformat, 'calendar']
    end

    icon            = picker.delete(:icon)
    isremove        = picker.delete(:isremove)
    picker[:format] = pp
    
    input_html_options[:value] ||= I18n.localize(value, :format => dp) if value.present?
    input_html_options[:type] = 'text'
    input_html_options[:class].push('form-control')
    input_html_options[:readonly] ||= true

    template.content_tag :div, class: 'input-group date', id: 'datepicker', data: picker do
      input = super

      input += template.content_tag :span, class: 'input-group-addon' do
        template.content_tag :i, '', class: 'icon-remove isremove'
      end if isremove

      input += template.content_tag :span, class: 'input-group-addon' do
        template.content_tag :i, '', class: 'ttc icon-' + icon
      end

      input
    end
  end
end