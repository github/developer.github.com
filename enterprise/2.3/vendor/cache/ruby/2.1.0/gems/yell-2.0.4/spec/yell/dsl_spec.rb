require 'spec_helper'

describe "Yell Adapter DSL spec" do

  class DSLAdapter < Yell::Adapters::Base

    setup do |options|
      @test_setup = true
    end

    write do |event|
      @test_write = true
    end

    close do
      @test_close = true
    end

    def test_setup?; !!@test_setup; end
    def test_write?; !!@test_write; end
    def test_close?; !!@test_close; end
  end

  it "should perform #setup" do
    adapter = DSLAdapter.new
    expect(adapter.test_setup?).to be_true
  end

  it "should perform #write" do
    event = 'event'
    stub(event).level { 0 }

    adapter = DSLAdapter.new
    expect(adapter.test_write?).to be_false

    adapter.write(event)
    expect(adapter.test_write?).to be_true
  end

  it "should perform #close" do
    adapter = DSLAdapter.new
    expect(adapter.test_close?).to be_false

    adapter.close
    expect(adapter.test_close?).to be_true
  end

end

