class SelectSubmitter {

  constructor(selectSelectorClass) {
    const selects = $('.' + selectSelectorClass);

    if (selects.length > 0) {
      selects.each(function(index, object) {
        $(object).on('change', () => {
          object.closest('form').submit();
        });
      });
    }
  }
}

export default SelectSubmitter;