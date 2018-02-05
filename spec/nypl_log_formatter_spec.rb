require 'spec_helper'
require 'json'
require 'tempfile'

# These tests are very light but, when used in a CI suite against multiple
# Ruby versions, serves as a bellwether of compatibility.
describe NyplLogFormatter do
  it "logs JSON" do
    tmp = Tempfile.new('flyingsaucerattack')
    logger = NyplLogFormatter.new(tmp)
    logger.error("never hit your grandma with a shovel")
    tmp.rewind
    parsed_log = JSON.parse(tmp.read)

    keys = %w{level message timestamp}
    expect(parsed_log.keys.length).to eq(keys.length)
    keys.each do |key|
      expect(parsed_log.keys).to include(key)
    end

    expect(parsed_log['level']).to eq("ERROR")

    tmp.close
  end
end
