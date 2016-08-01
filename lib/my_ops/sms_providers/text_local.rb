require 'my_ops/sms_provider'

module MyOps
  module SMSProviders
    class TextLocal < MyOps::SMSProvider

      self.provider_name = "TextLocal"
      self.provider_description = "Send alert SMS messages using the TextLocal service (www.textlocal.co.uk)"

      def send_message(recipient, message)
        Nifty::Utils::HTTP.post("https://api.txtlocal.com/send/",
          :params => {
            :username => MyOps.config.textlocal.username,
            :hash => MyOps.config.textlocal.hash,
            :sender => MyOps.config.textlocal.sender,
            :message => message,
            :numbers => recipient
          }
        )
      end

    end
  end
end
