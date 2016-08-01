require 'my_ops/sms_provider'
require 'nifty/utils/http'

module MyOps
  module SMSProviders
    class TextLocal < MyOps::SMSProvider

      self.provider_name = "TextLocal"
      self.provider_description = "Send alert SMS messages using the TextLocal service (www.textlocal.co.uk)"

      def send_message(recipient, message)
        response = Nifty::Utils::HTTP.post("https://api.txtlocal.com/send/",
          :params => {
            :username => MyOps.config.textlocal.username,
            :hash => MyOps.config.textlocal.auth_hash,
            :sender => MyOps.config.textlocal.sender,
            :message => message,
            :numbers => recipient
          }
        )
        response[:code] == 200
      end

    end
  end
end
