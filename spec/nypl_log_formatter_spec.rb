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
    expect(parsed_log['message']).to eq("never hit your grandma with a shovel")

    tmp.close
  end

  it "can log arbirary keys" do
    tmp = Tempfile.new('flyingsaucerattack')
    logger = NyplLogFormatter.new(tmp)
    logger.error(
      'never hit your grandma with a shovel',
      user: {email: 'simon@example.com', name: 'simon'},
      permissions: ['admin', 'good-boy']
    )
    tmp.rewind
    parsed_log = JSON.parse(tmp.read)

    # Logs a plain-old message
    expect(parsed_log['message']).to eq('never hit your grandma with a shovel')

    # Logs a key whose value is a hash/simple object
    expect(parsed_log['user']['email']).to eq('simon@example.com')
    expect(parsed_log['user']['name']).to eq('simon')

    # Logs a second key whos value is an Array
    expect(parsed_log['permissions']).to eq(['admin', 'good-boy'])
  end
end
