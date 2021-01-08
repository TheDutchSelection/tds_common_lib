import Rails from '@rails/ujs';

class SelfSubmittingForms {

  constructor(objectClass) {
    this.forms =  document.getElementsByClassName(objectClass);

    if (this.forms.length > 0) {
      this._setEventListeners();
    }
  }


  _setEventListeners() {
    let i;
    for (i = 0; i < this.forms.length; ++i) {
      const form = this.forms[i];
      const input_fields = form.elements

      let j;
      for (j = 0; j < input_fields.length; ++j) {
        const input_field = input_fields[j];

        $(input_field).on('change', () => {
          Rails.fire(form, 'submit');
        });
      }

      $(form)
        .on('submit', () => {
          let j;
          for (j = 0; j < input_fields.length; ++j) {
            const input_field = input_fields[j];

            input_field.readOnly = true;
          }
        })

        .on('ajax:success', (e, data, status, xhr) => {
          for (j = 0; j < input_fields.length; ++j) {
            const input_field = input_fields[j];

            input_field.readOnly = false;
            input_field.classList.remove("is-invalid");
          }

        })

        .on('ajax:error', (e, data, status, xhr) => {
          for (j = 0; j < input_fields.length; ++j) {
            const input_field = input_fields[j];

            input_field.readOnly = false;
            input_field.classList.add("is-invalid");
          }
        });
    }
  }
}

export default SelfSubmittingForms;
