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

  def silence(temporary_level = NyplLogFormatter::ERROR)
    old_local_level = self.level
    begin
      self.level = temporary_level
      yield self
    rescue Exception
      self.level = old_local_level
    ensure
      self.level = old_local_level
    end
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
        message:   msg.is_a?(Array) ? msg.shift : msg,
        timestamp: Time.now.strftime("%Y-%m-%dT%H:%M:%S.%L%z")
      }

      if msg.is_a?(Array)
        msg.each do |additional_key_values|
          additional_key_values.each do |key, value|
            message_hash[key] = value
          end
        end
      end

      if progname && !progname.empty?
        message_hash['programName'] = progname[0]
      end

      "#{JSON.generate(message_hash)}\n"
    end
  end

end
