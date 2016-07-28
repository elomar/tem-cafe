require 'minitest/autorun'
require_relative 'command_parser'

class CommandParserTest < Minitest::Test
  def test_returns_parsed_command_when_main_command_of_raw_command_is_present_in_whitelist
    parser = CommandParser.new(whitelist: [:fiz])

    assert_equal [:fiz], parser.call('fiz')
  end

  def test_returns_parsed_command_when_raw_command_matches_whitelist_but_has_spaces
    parser = CommandParser.new(whitelist: [:fez_cafe])

    assert_equal [:fez_cafe], parser.call('fez cafe')
  end

  def test_returns_parsed_command_when_raw_command_matches_whitelist_but_has_dashes
    parser = CommandParser.new(whitelist: [:fez_cafe])

    assert_equal [:fez_cafe], parser.call('fez-cafe')
  end

  def test_returns_parsed_command_when_main_command_of_raw_command_has_question_mark
    parser = CommandParser.new(whitelist: [:fez?])

    assert_equal [:fez?], parser.call('fez?')
  end

  def test_returns_parsed_command_with_arguments_when_raw_command_has_arguments
    parser = CommandParser.new(whitelist: [:quem_faz])

    assert_equal [:quem_faz, 'joao, maria'], parser.call('quem faz joao, maria')
  end

  def test_does_not_return_parsed_command_when_main_command_of_raw_command_is_not_at_the_start
    parser = CommandParser.new(whitelist: [:fiz])

    assert_nil parser.call('fez fiz')
    assert_nil parser.call('ffiz')
  end

  def test_does_not_return_parsed_command_when_main_command_of_raw_command_is_not_present_in_whitelist
    parser = CommandParser.new(whitelist: [:fez])

    assert_nil parser.call('fiz')
  end
end
