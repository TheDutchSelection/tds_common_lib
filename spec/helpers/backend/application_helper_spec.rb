require 'rails_helper'

RSpec.describe TdsCommonLib::Backend::ApplicationHelper, type: :helper do

  describe '.bootstrap_class_for_flash' do
    it 'should return the correct label classes for flash messages' do
      expect(helper.bootstrap_class_for_flash('success')).to eq 'alert-success'
      expect(helper.bootstrap_class_for_flash('error')).to eq 'alert-danger'
      expect(helper.bootstrap_class_for_flash('alert')).to eq 'alert-warning'
      expect(helper.bootstrap_class_for_flash('notice')).to eq 'alert-info'
      expect(helper.bootstrap_class_for_flash('something')).to eq 'something'
    end
  end

  describe '.status_label_class' do
    it 'should return the correct status label' do
      expect(helper.status_label_class('success')).to eq 'badge badge-success'
      expect(helper.status_label_class('approved')).to eq 'badge badge-success'
      expect(helper.status_label_class('done')).to eq 'badge badge-success'
      expect(helper.status_label_class('warning')).to eq 'badge badge-warning'
      expect(helper.status_label_class('queued')).to eq 'badge badge-warning'
      expect(helper.status_label_class('waiting_to_process')).to eq 'badge badge-info'
      expect(helper.status_label_class('danger')).to eq 'badge badge-danger'
      expect(helper.status_label_class('failed')).to eq 'badge badge-danger'
      expect(helper.status_label_class('rejected')).to eq 'badge badge-danger'
      expect(helper.status_label_class('unknown')).to eq 'badge badge-secondary'
    end
  end
end
