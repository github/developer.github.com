require 'spec_helper'

describe "running Yell multi-threaded" do
  let( :threads ) { 100 }
  let( :range ) { (1..threads) }

  let( :filename ) { fixture_path + '/threaded.log' }
  let( :lines ) { `wc -l #{filename}`.to_i }

  context "one instance" do
    before do
      logger = Yell.new filename

      range.map do |count|
        Thread.new { 10.times { logger.info count } }
      end.each(&:join)

      sleep 0.5
    end

    it "should write all messages" do
      lines.should == 10*threads
    end
  end

  # context "one instance per thread" do
  #   before do
  #     range.map do |count|
  #       Thread.new do
  #         logger = Yell.new( filename )

  #         10.times { logger.info count }
  #       end
  #     end.each(&:join)

  #     sleep 0.5
  #   end

  #   it "should write all messages" do
  #     lines.should == 10*threads
  #   end
  # end

  context "one instance in the repository" do
    before do
      Yell[ 'threaded' ] = Yell.new( filename )
    end

    it "should write all messages" do
      range.map do |count|
        Thread.new { 10.times { Yell['threaded'].info count } }
      end.each(&:join)

      lines.should == 10*threads
    end
  end

  context "multiple datefile instances" do
    let( :threadlist ) { [] }
    let( :date ) { Time.now }

    before do
      Timecop.freeze( date - 86400 )

      range.each do |count|
        threadlist << Thread.new do
          logger = Yell.new :datefile, :filename => filename, :keep => 2
          loop { logger.info :info; sleep 0.1 }
        end
      end

      sleep 0.3 # sleep to get some messages into the file
    end

    after do
      threadlist.each(&:kill)
    end

    it "should safely rollover" do
      # now cycle the days
      7.times do |count|
        Timecop.freeze( date + 86400*count )
        sleep 0.3

        files = Dir[ fixture_path + '/*.*.log' ]
        files.size.should == 2

        # files.last.should match( datefile_pattern_for(Time.now) ) # today
        # files.first.should match( datefile_pattern_for(Time.now-86400) ) # yesterday
      end
    end
  end

  private

  def datefile_pattern_for( time )
    time.strftime(Yell::Adapters::Datefile::DefaultDatePattern)
  end

end

