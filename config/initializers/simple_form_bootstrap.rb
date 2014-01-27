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
class SimpleForm::Inputs::DateTimeInput
  def input
    %{
      <div class="input-group date form_date" data-date="" data-date-format="yyyy MM dd" data-link-field="user_duty" data-link-format="yyyy-mm-dd">
        <input class="form-control" size="16" type="text" readonly>
        <span class="input-group-addon">
          <span class="icon-remove"></span>
        </span>
        <span class="input-group-addon">
          <i class="icon-calendar"></i>
        </span>
      </div>
      <input type="hidden" id="user_duty" name="user[duty]" value="" />
}.html_safe
  end
end
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
