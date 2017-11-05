# frozen_string_literal: true

describe NotificationWorker, type: :worker do
  context 'worker' do
    it { is_expected.to be_processed_in :default }

    it 'enqueues awesome job' do
      described_class.perform_async
      expect(described_class).to have_enqueued_sidekiq_job
    end
  end
end
