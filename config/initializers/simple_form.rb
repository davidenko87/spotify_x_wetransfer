# SimpleForm.setup do |config|
#   config.wrappers :default, class: :input,
#     hint_class: :field_with_hint, error_class: :field_with_errors, valid_class: :field_without_errors do |b|
#     b.use :html5
#     b.use :placeholder
#     b.optional :maxlength
#     b.optional :minlength
#     b.optional :pattern
#     b.optional :min_max
#     b.optional :readonly
#     b.use :label_input
#     b.use :hint,  wrap_with: { tag: :span, class: :hint }
#     b.use :error, wrap_with: { tag: :span, class: :error }
#   end

#   config.default_wrapper = :default

#   config.boolean_style = :nested

#   config.button_class = 'btn'

#   config.error_notification_tag = :div

#   config.error_notification_class = 'error_notification'

#   config.browser_validations = false
#   config.boolean_label_class = 'checkbox'
# end

SimpleForm.setup do |config|
  config.error_notification_class = 'error'
  config.button_class = 'button'

  config.wrappers :metro_form, tag: 'div' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label
    b.use :input
    b.use :error, wrap_with: { tag: 'div', class: 'message' }
    b.wrapper tag: :span, class: 'tooltip', unless_blank: true do |component|
      component.optional :hint,  wrap_with: { tag: :span, class: 'tooltip__content' }
    end
  end

  config.wrappers :metro_checkbox do |b|
    b.use :html5
    b.use :input, type: 'checkbox', 'data-role': 'checkbox'
  end


  config.default_wrapper = :metro_form
  config.wrapper_mappings = {
    text: :metro_form,
    check_boxes: :metro_checkbox,
    radio_buttons: :metro_form,
    file: :metro_form,
    boolean: :metro_form,
    slider: :metro_form
  }
end
