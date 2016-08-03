require 'minitest/autorun'
require 'ostruct'
require_relative 'cafe_dispatcher'

class CafeDispatcherTest < Minitest::Test
  class CommandParserFake
    def initialize(returns:)
      @returns = returns
    end

    def call(command)
      @returns
    end
  end

  def test_fails_when_args_returnd_by_command_parser_is_nil
    cafe = Object.new
    command_parser = CommandParserFake.new(returns: nil)
    dispatcher = CafeDispatcher.new(cafe, command_parser: command_parser)

    assert_raises(CafeDispatcher::ActionNotFound) { dispatcher.call('fiz') }
  end

  def test_fails_when_args_returned_by_command_parser_have_wrong_arity
    cafe = Object.new
    cafe.define_singleton_method(:quem_faz) { |one_argument| }
    command_parser = CommandParserFake.new(returns: [:quem_faz])
    dispatcher = CafeDispatcher.new(cafe, command_parser: command_parser)

    assert_raises(CafeDispatcher::ActionNotFound) { dispatcher.call('quem_faz') }
  end

  def test_dispatches_to_cafe_when_command_parser_returns_args_with_no_options
    cafe = Object.new
    cafe.define_singleton_method(:quem_faz?) { 'verify_me' }
    command_parser = CommandParserFake.new(returns: [:quem_faz?])
    dispatcher = CafeDispatcher.new(cafe, command_parser: command_parser)

    response = dispatcher.call('quem faz?')

    assert_equal 'verify_me', response
  end

  def test_dispatches_to_cafe_when_command_parser_returns_args_with_options
    cafe = Object.new
    cafe.define_singleton_method(:quem_faz) { |args| 'verify_me' }
    command_parser = CommandParserFake.new(returns: ['quem_faz', 'joao maria'])
    dispatcher = CafeDispatcher.new(cafe, command_parser: command_parser)

    response = dispatcher.call('quem faz')

    assert_equal 'verify_me', response
  end

  def test_returns_cafe_response_when_dispatched
    cafe = Object.new
    cafe.define_singleton_method(:quem_faz) { |names| 'OK, anotado' }
    command_parser = CommandParserFake.new(returns: ['quem_faz', 'joao maria'])
    dispatcher = CafeDispatcher.new(cafe, command_parser: command_parser)

    response = dispatcher.call('quem faz')

    assert_equal 'OK, anotado', response
  end
end
