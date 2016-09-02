require 'my_ops/sms_provider'
require 'nifty/utils/http'

module MyOps
  module SMSProviders
    class TextLocal < MyOps::SMSProvider

      self.provider_name = "TextLocal"
      self.provider_description = "Send alert SMS messages using the TextLocal service (www.textlocal.co.uk)"

      def send_message(recipient, message)
        self.class.logger.info "Sending to '#{recipient}' with message '#{message}'"
        response = Nifty::Utils::HTTP.post("https://api.txtlocal.com/send/",
          :params => {
            :username => self.class.config.username,
            :hash => self.class.config.auth_hash,
            :sender => self.class.config.sender,
            :message => message,
            :numbers => recipient
          }
        )

        if response[:code] == 200
          if response[:body]["errors"].is_a?(Array) && response[:body]["errors"].size > 0
            self.class.logger.warn "Couldn't send message to #{recipient}. #{response[:body].inspect}".red
            false
          else
            self.class.logger.debug "Successfully sent message to #{recipient}".green
            true
          end
        else
          self.class.logger.fatal "Couldn't send message to #{recipient}. API returned #{response[:code]} status.".red
          false
        end
      end

      def self.config
        MyOps.module_config["myops-textlocal"]
      end

      def self.logger
        @logger ||= Logger.new(Rails.root.join('log', 'textlocal.log'))
      end

    end
  end
end
