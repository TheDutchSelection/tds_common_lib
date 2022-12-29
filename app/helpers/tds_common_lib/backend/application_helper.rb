module TdsCommonLib
  module Backend
    module ApplicationHelper
      def bootstrap_class_for_flash(flash_type)
        case flash_type.to_s
        when 'success'
          'alert-success'
        when 'error'
          'alert-danger'
        when 'alert'
          'alert-warning'
        when 'notice'
          'alert-info'
        else
          "alert-#{flash_type}"
        end
      end

      def status_label_class(status)
        case status
        when 'approved', 'debugging_done', 'done', 'paid', 'success'
          'badge bg-success'
        when 'success_with_errors', 'warning'
          'badge bg-warning'
        when 'downloading', 'post_processing', 'processing', 'running', 'writing'
          'badge bg-primary'
        when 'closed', 'danger', 'failed', 'rejected'
          'badge bg-danger'
        when 'waiting_to_download', 'waiting_to_post_process', 'waiting_to_process'
          'badge bg-info'
        else
          'badge bg-secondary'
        end
      end
    end
  end
end
