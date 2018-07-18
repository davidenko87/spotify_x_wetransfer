# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.error_notification_class = 'alert alert-danger'
  config.button_class = 'btn'
  config.boolean_label_class = nil
  config.boolean_style = :inline
  config.item_wrapper_tag = :p

  config.wrappers :vanilla_form, tag: 'div', class: 'p-form-validation', error_class: 'is-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label
    b.use :input, class: 'p-form-validation__input'
    b.use :error, wrap_with: { tag: 'p', class: 'p-form-validation__message red-text' }
    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
  end

  config.wrappers :vanilla_text, tag: 'div', class: 'p-form-validation ', error_class: 'is-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label
    b.use :input, class: 'p-form-validation__input'
    b.use :error, wrap_with: { tag: 'p', class: 'p-form-validation__message red-text' }
    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
  end

  config.wrappers :vanilla_boolean, tag: 'div', class: '', error_class: 'is-error' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label
    b.use :input, class: 'p-form-validation__input'

    b.use :error, wrap_with: { tag: 'p', class: 'p-form-validation__message red-text' }
    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
  end

  config.wrappers :vanilla_toggle, tag: 'p', class: ' switch', error_class: 'is-error' do |b|
    b.use :html5
    b.optional :readonly

    b.use :label
    b.wrapper tag: 'label' do |ba|
      ba.use :input, class: 'p-form-validation__input'
      ba.use :tag, tag: 'span', class: 'lever'
    end

    b.use :error, wrap_with: { tag: 'p', class: 'p-form-validation__message red-text' }
    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
  end

  config.wrappers :vanilla_radio_and_checkboxes, tag: 'div', class: '', error_class: 'is-error' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label
    b.use :input, class: 'p-form-validation__input'
    b.use :error, wrap_with: { tag: 'p', class: 'p-form-validation__message red-text' }
    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
  end

  config.wrappers :vanilla_file_input, tag: 'div', class: 'file-field p-form-validation ', error_class: 'is-error' do |b|
    b.use :html5

    b.wrapper tag: :div, class: 'btn' do |ba|
      ba.use :tag, tag: :span, text: :label_text
      ba.use :input
    end

    b.wrapper tag: :div, class: 'file-path-wrapper' do |ba|
      ba.use :tag, tag: :input, class: 'file-path validate', type: 'text', placeholder: 'Browse...'
    end

    b.use :error, wrap_with: { tag: 'p', class: 'p-form-validation__message red-text' }
    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
  end

  config.wrappers :vanilla_multiple_file_input, tag: 'div', class: 'file-field p-form-validation ', error_class: 'is-error' do |b|
    b.use :html5

    b.wrapper tag: :div, class: 'btn' do |ba|
      ba.use :tag, tag: :span, text: :label_text
      ba.use :input, multiple: true
    end

    b.wrapper tag: :div, class: 'file-path-wrapper' do |ba|
      ba.use :tag, tag: :input, class: 'file-path validate', type: 'text', placeholder: 'Upload one or more files'
    end

    b.use :error, wrap_with: { tag: 'p', class: 'p-form-validation__message red-text' }
    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
  end

  config.wrappers :vanilla_slider, tag: 'div', class: 'p-form-validation', error_class: 'is-error' do |b|
    b.use :html5

    b.wrapper tag: :div, class: 'p-slider_wrapper' do |ba|
      ba.use :tag, tag: :input, class: 'p-slider', type: 'range'
      ba.use :tag, tag: :input, class: 'p-slider__input', type: 'text'
    end
  end

  config.default_wrapper = :vanilla_form
  config.wrapper_mappings = {
    text: :vanilla_text,
    check_boxes: :vanilla_radio_and_checkboxes,
    radio_buttons: :vanilla_radio_and_checkboxes,
    file: :vanilla_file_input,
    boolean: :vanilla_boolean,
    slider: :vanilla_slider
  }
end
