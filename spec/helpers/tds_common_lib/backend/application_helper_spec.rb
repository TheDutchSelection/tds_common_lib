require 'rails_helper'

module TdsCommonLib
  RSpec.describe Backend::ApplicationHelper, type: :helper do

    describe '.bootstrap_class_for_flash' do
      it 'should return the correct label classes for flash messages' do
        expect(helper.bootstrap_class_for_flash('success')).to eq 'alert-success'
        expect(helper.bootstrap_class_for_flash('error')).to eq 'alert-danger'
        expect(helper.bootstrap_class_for_flash('alert')).to eq 'alert-warning'
        expect(helper.bootstrap_class_for_flash('notice')).to eq 'alert-info'
        expect(helper.bootstrap_class_for_flash('something')).to eq 'alert-something'
      end
    end

    describe '.status_label_class' do
      it 'should return the correct status label' do
        expect(helper.status_label_class('success')).to eq 'badge bg-success'
        expect(helper.status_label_class('approved')).to eq 'badge bg-success'
        expect(helper.status_label_class('done')).to eq 'badge bg-success'
        expect(helper.status_label_class('warning')).to eq 'badge bg-warning'
        expect(helper.status_label_class('waiting_to_process')).to eq 'badge bg-info'
        expect(helper.status_label_class('danger')).to eq 'badge bg-danger'
        expect(helper.status_label_class('failed')).to eq 'badge bg-danger'
        expect(helper.status_label_class('rejected')).to eq 'badge bg-danger'
        expect(helper.status_label_class('unknown')).to eq 'badge bg-secondary'
      end
    end
  end
end
