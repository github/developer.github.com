# encoding: utf-8

name        'help'
usage       'help [command_name]'
summary     'show help'
description <<-EOS
Show help for the given command, or show general help. When no command is
given, a list of available commands is displayed, as well as a list of global
commandline options. When a command is given, a command description as well as
command-specific commandline options are shown.
EOS

flag :v, :verbose, 'show more detailed help'

run do |opts, args, cmd|
  if cmd.supercommand.nil?
    raise NoHelpAvailableError,
      "No help available because the help command has no supercommand"
  end

  is_verbose = opts.fetch(:verbose, false)

  resolved_cmd = args.inject(cmd.supercommand) do |acc, name|
    acc.command_named(name)
  end
  puts resolved_cmd.help(:verbose => is_verbose, :io => $stdout)
end
