#--
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Acton < OmniAuth::Strategies::OAuth2

      option :client_options, {
          site: 'https://restapi.actonsoftware.com',
          authorize_url: '/authorize',
          token_url: '/token'
      }

      option :name, 'acton'

      option :authorize_options, [:scope]

      uid { raw_info['account_id'] }

      info do
        prune!(
            'name' => raw_info['user_name'],
            'email' => raw_info['user_email'],
            'type' => raw_info['user_type'],
        )
      end

      extra do
        {'user' => prune!(raw_info)}
      end

      def raw_info
        @raw_info ||= access_token.get('/api/1/account').parsed
      end

      private

      def prune!(hash)
        hash.delete_if do |_, value|
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end

    end
  end
end

OmniAuth.config.add_camelization 'acton', 'Acton'
