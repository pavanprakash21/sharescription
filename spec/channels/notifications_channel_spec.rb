# # frozen_string_literal: true
#
# # This is the minimal ActionCable connection stub to make the test pass
# class TestConnection
#   attr_reader :identifiers, :logger
#
#   def initialize(identifiers_hash = {})
#     @identifiers = identifiers_hash.keys
#     @logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new(StringIO.new))
#
#     # This is an equivalent of providing `identified_by :identifier_key` in ActionCable::Connection::Base subclass
#     identifiers_hash.each do |identifier, value|
#       define_singleton_method(identifier) do
#         value
#       end
#     end
#   end
# end
#
# describe NotificationsChannel do
#   subject(:channel) { described_class.new(connection, {}) }
#
#   # Connection is `identified_by :current_user`
#   let(:current_user) { create :user }
#
#   let(:connection) { TestConnection.new(current_user: current_user) }
#
#   let(:action_cable) { ActionCable.server }
#
#   # ActionCable dispatches actions by the `action` attribute.
#   # In this test we assume the payload was successfully parsed (it could be a JSON payload, for example).
#   let(:data) do
#     {
#       'action' => 'notifications_action'
#     }
#   end
#
#   it "broadcasts 'Hello, Bob!' 3 times" do
#     expect(action_cable).to have_received(:broadcast).with('1', 'Hello, Bob!').exactly(3).times
#
#     channel.perform_action(data)
#   end
# end

describe NotificationsChannel, type: :channel do
  let(:user) { create :user }

  before do
    # initialize connection with identifiers
    stub_connection current_user: user
  end

  it 'confirms connection' do
    subscribe
    expect(subscription).to be_confirmed
  end

  it 'subscribes to a stream' do
    subscribe
    expect(streams).to include("notifications_user_#{user.id}")
  end
end
