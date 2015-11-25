require 'set'
require 'forwardable'
require 'timers/version'

# Low precision timers implemented in pure Ruby
class Timers
  include Enumerable
  extend  Forwardable
  def_delegators :@timers, :delete, :each, :empty?

  def initialize
    @timers = SortedSet.new
  end

  # Call the given block after the given interval
  def after(interval, &block)
    Timer.new(self, interval, false, &block)
  end
  
  # Call the given block after the given interval has expired. +interval+
  # is measured in milliseconds.
  #
  #  Timer.new.after_milliseconds(25) { puts "fired!" }
  #
  def after_milliseconds(interval, &block)
    after(interval / 1000.0, &block)
  end
  alias_method :after_ms, :after_milliseconds

  # Call the given block periodically at the given interval
  def every(interval, &block)
    Timer.new(self, interval, true, &block)
  end

  # Wait for the next timer and fire it
  def wait
    i = wait_interval
    sleep i if i
    fire
  end

  # Interval to wait until when the next timer will fire
  def wait_interval(now = Time.now)
    timer = @timers.first
    return unless timer
    interval = timer.time - now
    interval > 0 ? interval : 0
  end

  # Fire all timers that are ready
  def fire(now = Time.now)
    time = now + 0.001 # Fudge 1ms in case of clock imprecision
    while (timer = @timers.first) && (time >= timer.time)
      @timers.delete timer
      timer.fire(now)
    end
  end

  def add(timer)
    raise TypeError, "not a Timers::Timer" unless timer.is_a? Timers::Timer
    @timers.add(timer)
  end

  alias_method :cancel, :delete

  # An individual timer set to fire a given proc at a given time
  class Timer
    include Comparable
    attr_reader :interval, :time, :recurring

    def initialize(timers, interval, recurring = false, &block)
      @timers, @interval, @recurring = timers, interval, recurring
      @block = block
      @time  = nil

      reset
    end

    def <=>(other)
      @time <=> other.time
    end

    # Cancel this timer
    def cancel
      @timers.cancel self
    end

    # Reset this timer
    def reset(now = Time.now)
      @timers.cancel self if @time
      @time = now + @interval
      @timers.add self
    end

    # Fire the block
    def fire(now = Time.now)
      reset(now) if recurring
      @block.call
    end
    alias_method :call, :fire

    # Inspect a timer
    def inspect
      str = "#<Timers::Timer:#{object_id.to_s(16)} "
      now = Time.now

      if @time
        if @time >= now
          str << "fires in #{@time - now} seconds"
        else
          str << "fired #{now - @time} seconds ago"
        end

        str << ", recurs every #{interval}" if recurring
      else
        str << "dead"
      end

      str << ">"
    end
  end
end
