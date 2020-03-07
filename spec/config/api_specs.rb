module APIAuthenticationMacro
  def mock_authenticate_request
    let(:current_user) { build(:user, :with_fake_id) }

    before do
      Grape::Endpoint.before_each do |endpoint|
        allow(endpoint).to receive(:authenticate_request!).and_return(true)
        allow(endpoint).to receive(:current_user).and_return(current_user)
      end
    end

    after do
      Grape::Endpoint.before_each nil
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Rails::RequestExampleGroup, type: :api
  config.extend APIAuthenticationMacro, type: :api
end
