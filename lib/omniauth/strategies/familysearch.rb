require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class FamilySearch < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://api.familysearch.org',
        :authorize_url => '/cis-web/oauth2/v3/authorization',
        :token_url => '/cis-web/oauth2/v3/token'
      }

      def request_phase
        super
      end

      def authorize_params
        super
      end

      uid { user_info['id'] }

      info do
        {
          :name => user_name,
          :email => user_email
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def raw_info
        @raw_info ||= access_token.get('/platform/users/current',
                                       :headers => { 'Accept' => 'application/x-fs-v1+json' },
                                       :parse => :json
                                      ).parsed
      end

      def user_info
        @user_info ||= raw_info['users'] ? raw_info['users'].first : {}
      end

      def user_name
        user_info['contactName']
      end

      def user_email
        user_info['email']
      end

    end
  end
end

OmniAuth.config.add_camelization 'familysearch', 'FamilySearch'
