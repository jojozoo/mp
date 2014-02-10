# ClientSideValidations Initializer

# Uncomment to disable uniqueness validator, possible security issue
# ClientSideValidations::Config.disabled_validators = [:uniqueness]
ClientSideValidations::Config.disabled_validators = []

# Uncomment to validate number format with current I18n locale
ClientSideValidations::Config.number_format_with_locale = true

# Uncomment the following block if you want each input field to have the validation messages attached.
#
# Note: client_side_validation requires the error to be encapsulated within
# <label for="#{instance.send(:tag_id)}" class="message"></label>
#
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  unless html_tag =~ /^<label/
    # 需要配合/Users/bp/work/mp/app/assets/javascripts/rails.validations.simple_form.js 文件改正
    %{<div class="has-error">#{html_tag}<label for="#{instance.send(:tag_id)}" class="message help-block">#{instance.error_message.first}</label></div>}.html_safe
  else
    %{<div class="has-error">#{html_tag}</div>}.html_safe
  end
end
