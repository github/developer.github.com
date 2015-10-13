Timers
======
[![Build Status](https://secure.travis-ci.org/tarcieri/timers.png?branch=master)](http://travis-ci.org/tarcieri/timers)

Pure Ruby timer collections. Schedule several procs to fire after configurable
delays or at periodic intervals.

This gem is especially useful when you are faced with an API that accepts a
single timeout but you want to run multiple timers on top of it. An example of
such a library is [nio4r](https://github.com/tarcieri/nio4r), a cross-platform
Ruby library for using system calls like epoll and kqueue.

Usage
-----

Create a new timer group with `Timers.new`:

```ruby
require 'timers'

timers = Timers.new
```

Schedule a proc to run after 5 seconds with `Timers#after`:

```ruby
five_second_timer = timers.after(5) { puts "Take five" }
```

The `five_second_timer` variable is now bound to a Timers::Timer object. To
cancel a timer, use `Timers::Timer#cancel`

Once you've scheduled a timer, you can wait until the next timer fires with `Timers#wait`:

```ruby
# Waits 5 seconds
timers.wait

# The script will now print "Take five"
```

You can schedule a block to run periodically with `Timers#every`:

```ruby
every_five_seconds = timers.every(5) { puts "Another 5 seconds" }

loop { timers.wait }
```

If you'd like another method to do the waiting for you, e.g. `Kernel.select`,
you can use `Timers#wait_interval` to obtain the amount of time to wait. When
a timeout is encountered, you can fire all pending timers with `Timers#fire`:

```ruby
loop do
  interval = timers.wait_interval
  ready_readers, ready_writers = select readers, writers, nil, interval

  if ready_readers || ready_writers
    # Handle IO
    ...
  else
    # Timeout!
    timers.fire
  end
end
```

License
-------

Copyright (c) 2012 Tony Arcieri. Distributed under the MIT License. See
LICENSE for further details.
