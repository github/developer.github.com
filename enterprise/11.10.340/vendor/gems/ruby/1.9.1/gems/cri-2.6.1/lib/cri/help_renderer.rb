# encoding: utf-8

module Cri

  # The {HelpRenderer} class is responsible for generating a string containing
  # the help for a given command, intended to be printed on the command line.
  class HelpRenderer

    # Creates a new help renderer for the given command.
    #
    # @param [Cri::Command] cmd The command to generate the help for
    #
    # @option params [Boolean] :verbose true if the help output should be
    #   verbose, false otherwise.
    def initialize(cmd, params={})
      @cmd        = cmd
      @is_verbose = params.fetch(:verbose, false)
      @io         = params.fetch(:io, $stdout)
    end

    # @return [String] The help text for this command
    def render
      text = ''

      append_summary(text)
      append_usage(text)
      append_description(text)
      append_subcommands(text)
      append_options(text)

      text
    end

    private

    def fmt
      @_formatter ||= Cri::StringFormatter.new
    end

    def append_summary(text)
      return if @cmd.summary.nil?

      text << fmt.format_as_title("name", @io) << "\n"
      text << "    #{fmt.format_as_command(@cmd.name, @io)} - #{@cmd.summary}" << "\n"
      unless @cmd.aliases.empty?
        text << "    aliases: " << @cmd.aliases.map { |a| fmt.format_as_command(a, @io) }.join(' ') << "\n"
      end
    end

    def append_usage(text)
      return if @cmd.usage.nil?

      path = [ @cmd.supercommand ]
      path.unshift(path[0].supercommand) until path[0].nil?
      formatted_usage = @cmd.usage.gsub(/^([^\s]+)/) { |m| fmt.format_as_command(m, @io) }
      full_usage = path[1..-1].map { |c| fmt.format_as_command(c.name, @io) + ' ' }.join + formatted_usage

      text << "\n"
      text << fmt.format_as_title("usage", @io) << "\n"
      text << fmt.wrap_and_indent(full_usage, 78, 4) << "\n"
    end

    def append_description(text)
      return if @cmd.description.nil?

      text << "\n"
      text << fmt.format_as_title("description", @io) << "\n"
      text << fmt.wrap_and_indent(@cmd.description, 78, 4) + "\n"
    end

    def append_subcommands(text)
      return if @cmd.subcommands.empty?

      text << "\n"
      text << fmt.format_as_title(@cmd.supercommand ? 'subcommands' : 'commands', @io)
      text << "\n"

      shown_subcommands = @cmd.subcommands.select { |c| !c.hidden? || @is_verbose }
      length = shown_subcommands.map { |c| fmt.format_as_command(c.name, @io).size }.max

      # Command
      shown_subcommands.sort_by { |cmd| cmd.name }.each do |cmd|
        text << sprintf("    %-#{length+4}s %s\n",
          fmt.format_as_command(cmd.name, @io),
          cmd.summary)
      end

      # Hidden notice
      if !@is_verbose
        diff = @cmd.subcommands.size - shown_subcommands.size
        case diff
        when 0
        when 1
          text << "    (1 hidden command omitted; show it with --verbose)\n"
        else
          text << "    (#{diff} hidden commands omitted; show them with --verbose)\n"
        end
      end
    end

    def append_options(text)
      groups = { 'options' => @cmd.option_definitions }
      if @cmd.supercommand
        groups["options for #{@cmd.supercommand.name}"] = @cmd.supercommand.global_option_definitions
      end
      length = groups.values.inject(&:+).map { |o| o[:long].to_s.size }.max
      groups.keys.sort.each do |name|
        defs = groups[name]
        append_option_group(text, name, defs, length)
      end
    end

    def append_option_group(text, name, defs, length)
      return if defs.empty?

      text << "\n"
      text << fmt.format_as_title("#{name}", @io)
      text << "\n"

      ordered_defs = defs.sort_by { |x| x[:short] || x[:long] }
      ordered_defs.each do |opt_def|
        text << format_opt_def(opt_def, length)
        text << opt_def[:desc] << "\n"
      end
    end

    def format_opt_def(opt_def, length)
      opt_text = sprintf(
          "    %-2s %-#{length+6}s",
          opt_def[:short] ? ('-' + opt_def[:short]) : '',
          opt_def[:long]  ? ('--' + opt_def[:long]) : '')
      fmt.format_as_option(opt_text, @io)
    end

  end

end
