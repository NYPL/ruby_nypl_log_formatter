require 'nypl_log_formatter/version'
require 'logger'
require 'json'

class NyplLogFormatter < ::Logger

  include NyplLogFormatterVersion

  def initialize(*args)
    super(*args)
    # This has to happen _after_ call to super, otherwise ::Logger will set the formatter
    set_formatter
  end

private

  def set_formatter
    self.formatter = proc do |severity, datetime, progname, msg|
      message_hash = {
        level:     severity.upcase,
        message:   msg,
        timestamp: Time.now.strftime("%Y-%m-%dT%H:%M:%S.%L%z")
      }
      "#{JSON.generate(message_hash)}\n"
    end
  end

end
