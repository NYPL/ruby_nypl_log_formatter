require 'nypl_log_formatter/version'
require 'logger'
require 'json'

class NyplLogFormatter < ::Logger

  include NyplLogFormatterVersion

  def initialize(*args)
    super(*args)
    # This has to happen _after_ call to super, otherwise ::Logger will set the formatter
    set_formatter
    allow_arbitrary_keys
  end

  private

  # Redefines #log(), #error(), etc...but explodes the `progname` arg
  # to be more than a simple string.
  # See original implementations here: https://github.com/ruby/ruby/blob/trunk/lib/logger.rb#L524
  def allow_arbitrary_keys
    Logger::Severity.constants.each do |severity_name|
      define_singleton_method(severity_name.to_s.downcase.to_sym) do |*progname, &block|
        add(eval(severity_name.to_s), nil, progname, &block)
      end
    end
  end

  def set_formatter
    self.formatter = proc do |severity, datetime, progname, msg|
      message_hash = {
        level:     severity.upcase,
        message:   msg.shift,
        timestamp: Time.now.strftime("%Y-%m-%dT%H:%M:%S.%L%z")
      }
      msg.each do |additional_key_values|
        additional_key_values.each do |key, value|
          message_hash[key] = value
        end
      end

      "#{JSON.generate(message_hash)}\n"
    end
  end

end
