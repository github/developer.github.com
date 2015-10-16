require 'spec_helper'

describe Timers do
  # Level of accuracy enforced by most tests (50ms)
  Q = 0.05

  it "sleeps until the next timer" do
    interval   = Q * 2
    started_at = Time.now

    fired = false
    subject.after(interval) { fired = true }
    subject.wait

    fired.should be_true
    (Time.now - started_at).should be_within(Q).of interval
  end

  it "fires instantly when next timer is in the past" do
    fired = false
    subject.after(Q) { fired = true }
    sleep(Q * 2)
    subject.wait

    fired.should be_true
  end

  it "calculates the interval until the next timer should fire" do
    interval = 0.1

    subject.after(interval)
    subject.wait_interval.should be_within(Q).of interval

    sleep(interval)
    subject.wait_interval.should be(0)
  end

  it "fires timers in the correct order" do
    result = []

    subject.after(Q * 2) { result << :two }
    subject.after(Q * 3) { result << :three }
    subject.after(Q * 1) { result << :one }

    sleep Q * 4
    subject.fire

    result.should == [:one, :two, :three]
  end

  describe "recurring timers" do
    it "continues to fire the timers at each interval" do
      result = []

      subject.every(Q * 2) { result << :foo }

      sleep Q * 3
      subject.fire
      result.should == [:foo]

      sleep Q * 5
      subject.fire
      result.should == [:foo, :foo]
    end
  end
  
  describe "millisecond timers" do
    it "calculates the proper interval to wait until firing" do
      interval_ms = 25

      subject.after_milliseconds(interval_ms)
      expected_elapse = subject.wait_interval

      subject.wait_interval.should be_within(Q).of (interval_ms / 1000.0)
    end
  end
end
