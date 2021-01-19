module TdsCommonLib
  module Backend
    module ApplicationHelper
      def bootstrap_class_for_flash(flash_type)
        case flash_type
        when 'success'
          'alert-success'
        when 'error'
          'alert-danger'
        when 'alert'
          'alert-warning'
        when 'notice'
          'alert-info'
        else
          flash_type.to_s
        end
      end

      def status_label_class(status)
        case status
        when 'approved', 'done', 'paid', 'success'
          'badge badge-success'
        when 'distribution_done', 'queued', 'success_with_errors', 'warning'
          'badge badge-warning'
        when 'being_distributed', 'running', 'writing'
          'badge badge-primary'
        when 'closed', 'danger', 'failed', 'rejected'
          'badge badge-danger'
        when 'waiting_to_process'
          'badge badge-info'
        else
          'badge badge-secondary'
        end
      end
    end
  end
end
