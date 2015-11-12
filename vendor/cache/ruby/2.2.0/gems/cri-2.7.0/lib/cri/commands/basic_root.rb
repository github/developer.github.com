# encoding: utf-8

flag :h, :help, 'show help for this command' do |_value, cmd|
  puts cmd.help
  exit 0
end

subcommand Cri::Command.new_basic_help
