require 'spec_helper'

describe OmniAuth::Strategies::FamilySearch do
  let(:access_token) { stub('AccessToken', :options => {}) }
  let(:parsed_response) { stub('ParsedResponse') }
  let(:response) { stub('Response', :parsed => parsed_response) }

  let(:sandbox_site)          { 'https://sandbox.familysearch.org' }
  let(:sandbox_authorize_url) { 'https://sandbox.familysearch.org/cis-web/oauth2/v3/authorization' }
  let(:sandbox_token_url)     { 'https://sandbox.familysearch.org/cis-web/oauth2/v3/token' }
  let(:sandbox) do
    OmniAuth::Strategies::FamilySearch.new('FAMILYSEARCH_DEVELOPER_KEY', '',
        {
            :client_options => {
                :site => sandbox_site,
                :authorize_url => sandbox_authorize_url,
                :token_url => sandbox_token_url
            }
        }
    )
  end

  subject do
    OmniAuth::Strategies::FamilySearch.new({})
  end

  before(:each) do
    subject.stub!(:access_token).and_return(access_token)
  end

  context 'client options' do
    it 'should have correct site' do
      subject.options.client_options.site.should eq('https://api.familysearch.org')
    end

    it 'should have correct authorize url' do
      subject.options.client_options.authorize_url.should eq('/cis-web/oauth2/v3/authorization')
    end

    it 'should have correct token url' do
      subject.options.client_options.token_url.should eq('/cis-web/oauth2/v3/token')
    end

    describe 'should be overrideable' do
      it 'for site' do
        sandbox.options.client_options.site.should eq(sandbox_site)
      end

      it 'for authorize url' do
        sandbox.options.client_options.authorize_url.should eq(sandbox_authorize_url)
      end

      it 'for token url' do
        sandbox.options.client_options.token_url.should eq(sandbox_token_url)
      end
    end
  end

  context 'uid' do
    it 'should return uid from user info if available' do
      subject.stub!(:raw_info).and_return({ 'users' => [{ 'id' => 'MMDZ-85L' }] })
      subject.uid.should eq('MMDZ-85L')
    end

    it 'should return nil if there is no raw_info' do
      subject.stub!(:raw_info).and_return({})
      subject.uid.should be_nil
    end
  end

  context 'info' do
    before(:each) do
      subject.stub!(:raw_info).and_return({})
    end

    it 'should include name key' do
      subject.info.should have_key(:name)
    end

    it 'should include email key' do
      subject.info.should have_key(:email)
    end
  end

  context 'extra' do
    it 'should ' do
      subject.stub!(:raw_info).and_return({})
      subject.extra.should have_key(:raw_info)
    end
  end

  context '#raw_info' do
    it 'should use relative path' do
      path = '/platform/users/current'
      opts = { :headers => { 'Accept' => 'application/x-fs-v1+json' }, :parse => :json }
      access_token.should_receive(:get).with(path, opts).and_return(response)
      subject.raw_info.should eq(parsed_response)
    end
  end

  context '#user_info' do
    it 'should return first hash from users array' do
      subject.stub!(:raw_info).and_return({ 'users' => [{ 'first' => 'user' }] })
      subject.user_info.should eq({ 'first' => 'user' })
    end
  end

  context '#user_name' do
    it 'should return email from raw_info if available' do
      subject.stub!(:raw_info).and_return({ 'users' => [{ 'contactName' => 'John Doe' }] })
      subject.user_name.should eq('John Doe')
    end

    it 'should return nil if there is no raw_info' do
      subject.stub!(:raw_info).and_return({})
      subject.user_name.should be_nil
    end
  end

  context '#user_email' do
    it 'should return email from raw_info if available' do
      subject.stub!(:raw_info).and_return({ 'users' => [{ 'email' => 'name@example.com' }] })
      subject.user_email.should eq('name@example.com')
    end

    it 'should return nil if there is no raw_info' do
      subject.stub!(:raw_info).and_return({})
      subject.user_email.should be_nil
    end
  end

end
