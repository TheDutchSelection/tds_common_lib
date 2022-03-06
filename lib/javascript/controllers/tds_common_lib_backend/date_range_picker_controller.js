require("daterangepicker");
import moment from "moment";
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    initialEndDate: String,
    initialStartDate: String,
    maxDate: String,
    minDate: String
  }

  connect() {
    this.loadDateRangePicker();
  }

  loadDateRangePicker() {
    const defaultEndDate = moment();
    const defaultMaxDate = moment().add(1, "years").endOf("year");
    const defaultMinDate = moment().subtract(100, "years").startOf("year");
    const defaultStartDate = moment();

    let initialEndDate, initialStartDate;

    if (this.initialEndDateValue && this.initialStartDateValue) {
      initialEndDate = moment(this.initialEndDateValue, "YYYY-MM-DD");
      initialStartDate = moment(this.initialStartDateValue, "YYYY-MM-DD");
    } else {
      initialEndDate = defaultEndDate;
      initialStartDate = defaultStartDate;
    }

    $(this.element).daterangepicker({
      alwaysShowCalendars: true,
      autoApply: true,
      endDate: initialEndDate,
      locale: {
        format: "DD-MM-YYYY"
      },
      maxDate: this.maxDateValue || defaultMaxDate,
      minDate: this.minDateValue || defaultMinDate,
      ranges: {
        "Today": [moment(), moment()],
        "Yesterday": [moment().subtract(1, "days"), moment().subtract(1, "days")],
        "Last 7 Days": [moment().subtract(6, "days"), moment()],
        "Last 30 Days": [moment().subtract(29, "days"), moment()],
        "This Month": [moment().startOf("month"), moment().endOf("month")],
        "Last Month": [moment().subtract(1, "month").startOf("month"), moment().subtract(1, "month").endOf("month")]
      },
      showDropdowns: true,
      startDate: initialStartDate
    });
  }
}
