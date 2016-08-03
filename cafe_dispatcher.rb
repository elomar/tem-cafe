class CafeDispatcher
  ActionNotFound = Class.new(StandardError)

  def initialize(cafe, command_parser:)
    @cafe = cafe
    @command_parser = command_parser
  end

  def call(command)
    args = @command_parser.call(command)
    fail ActionNotFound unless valid_args?(args)

    dispatch_and_return_response(args)
  end

  private

  def valid_args?(args)
    !args.nil? && @cafe.method(args[0]).arity == args.length - 1
  end

  def dispatch_and_return_response(args)
    @cafe.public_send(*args)
  end
end
