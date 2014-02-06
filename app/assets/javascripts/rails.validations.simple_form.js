/*
  Client Side Validations - SimpleForm - v2.1.0
  https://github.com/dockyard/client_side_validations-simple_form

  Copyright (c) 2013 DockYard, LLC
  Licensed under the MIT license
  http://www.opensource.org/licenses/mit-license.php
*/


(function() {
  // custom
  // 需要配合 /Users/bp/work/mp/config/initializers/client_side_validations.rb 改正
  // window.ClientSideValidations.formBuilders = {
  //   'ActionView::Helpers::FormBuilder': {
  //     add: function(element, settings, message) {
  //       var form, inputErrorField, label, labelErrorField;
  //       form = $(element[0].form);
  //       // 验证为true 并且不存在error tip
  //       if (element.data('valid') !== false && (form.find("label.message[for='" + (element.attr('id')) + "']")[0] == null)) {
  //         inputErrorField = jQuery(settings.input_tag);
  //         labelErrorField = jQuery(settings.label_tag);
  //         label = form.find("label[for='" + (element.attr('id')) + "']:not(.message)");
  //         if (element.attr('autofocus')) {
  //           element.attr('autofocus', false);
  //         }
  //         element.before(inputErrorField);
  //         inputErrorField.find('span#input_tag').replaceWith(element);
  //         inputErrorField.find('label.message').attr('for', element.attr('id'));
  //         labelErrorField.find('label.message').attr('for', element.attr('id'));
  //         labelErrorField.insertAfter(label);
  //         labelErrorField.find('label#label_tag').replaceWith(label);
  //       }
  //       return form.find("label.message[for='" + (element.attr('id')) + "']").text(message);
  //     },
  //     remove: function(element, settings) {
  //       var errorFieldClass, form, inputErrorField, label, labelErrorField;
  //       form = $(element[0].form);
  //       errorFieldClass = jQuery(settings.input_tag).attr('class');
  //       inputErrorField = element.closest("." + (errorFieldClass.replace(" ", ".")));
  //       label = form.find("label[for='" + (element.attr('id')) + "']:not(.message)");
  //       labelErrorField = label.closest("." + errorFieldClass);
  //       if (inputErrorField[0]) {
  //         inputErrorField.find("#" + (element.attr('id'))).detach();
  //         inputErrorField.replaceWith(element);
  //         label.detach();
  //         return labelErrorField.replaceWith(label);
  //       }
  //     }
  //   }
  // };
  // bootstrap
  ClientSideValidations.formBuilders['SimpleForm::FormBuilder'] = {
    add: function(element, settings, message) {
      return this.wrappers[settings.wrapper].add.call(this, element, settings, message);
    },
    remove: function(element, settings) {
      return this.wrappers[settings.wrapper].remove.call(this, element, settings);
    },
    wrappers: {
      "default": {
        add: function(element, settings, message) {
          var errorElement, wrapper;

          errorElement = element.parent().find("" + settings.error_tag + "." + settings.error_class);
          wrapper = element.closest(settings.wrapper_tag);
          if (errorElement[0] == null) {
            errorElement = $("<" + settings.error_tag + "/>", {
              "class": settings.error_class,
              text: message
            });
            wrapper.append(errorElement);
          }
          wrapper.addClass(settings.wrapper_error_class);
          return errorElement.text(message);
        },
        remove: function(element, settings) {
          var errorElement, wrapper;

          wrapper = element.closest("" + settings.wrapper_tag + "." + settings.wrapper_error_class);
          wrapper.removeClass(settings.wrapper_error_class);
          errorElement = wrapper.find("" + settings.error_tag + "." + settings.error_class);
          return errorElement.remove();
        }
      },
      bootstrap: {
        add: function(element, settings, message) {
          var errorElement, wrapper_class_element, wrapper_tag_element;

          errorElement = element.parent().find("" + settings.error_tag + "." + settings.error_class);
          if (errorElement[0] == null) {
            wrapper_tag_element = element.closest(settings.wrapper_tag);
            errorElement = $("<" + settings.error_tag + "/>", {
              "class": settings.error_class,
              text: message
            });
            // wrapper_tag_element.append(errorElement);
            wrapper_tag_element.parent().find('.form-error-tip').remove();
            wrapper_tag_element.parent().append(errorElement);
          }
          wrapper_class_element = element.closest("." + settings.wrapper_class);
          wrapper_class_element.addClass(settings.wrapper_error_class);
          return errorElement.text(message);
        },
        remove: function(element, settings) {
          var errorElement, wrapper_class_element, wrapper_tag_element;

          wrapper_class_element = element.closest("." + settings.wrapper_class + "." + settings.wrapper_error_class);
          wrapper_tag_element = element.closest(settings.wrapper_tag);
          wrapper_class_element.removeClass(settings.wrapper_error_class);
          errorElement = wrapper_tag_element.parent().find("" + settings.error_tag + "." + settings.error_class.split(' ').join('.'));
          return errorElement.remove();
        }
      }
    }
  };

}).call(this);
