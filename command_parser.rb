require 'forwardable'

class CommandParser
  def initialize(whitelist:)
    @whitelist = Whitelist.new(whitelist)
  end

  def call(command)
    @whitelist.each do |action_definition|
      args = decompose_command(*action_definition, command)
      return args if args
    end

    nil
  end

  private

  def decompose_command(action_name, action_regex, command)
    return unless command =~ action_regex

    arguments = command.gsub(action_regex, '').strip
    arguments = nil if arguments.empty?

    [action_name, *arguments]
  end

  class Whitelist
    extend Forwardable

    delegate each: :@whitelist

    def initialize(whitelist)
      @whitelist = whitelist.map { |action| parse_action(action) }
    end

    private

    def parse_action(action_name)
      [action_name, /\A#{build_action_regex(action_name)}/]
    end

    def build_action_regex(action_name)
      Regexp.escape(action_name).to_s.gsub(/[-_\s]/, '[-_\s]')
    end
  end

  private_constant :Whitelist
end
