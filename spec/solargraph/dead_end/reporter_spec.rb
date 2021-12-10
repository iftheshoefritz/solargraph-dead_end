# frozen_string_literal: true

require "solargraph-dead_end"
require "spec_helper"
require "byebug"

RSpec.describe Solargraph::DeadEnd do
  it "correct error report for unclosed end" do
    source = Solargraph::Source.load_string(
      <<~SRC
        class MyClass
          def test_method
        end
      SRC
    )
    reporter = Solargraph::DeadEnd::Reporter.new
    errors = reporter.diagnose(source, nil)

    expect(errors).to include(
      hash_including(
        message: a_string_matching(/Unmatched keyword, missing `end' ?/),
        range: hash_including(
          start: hash_including(line: 1, character: 0),
          end: hash_including(line: 1, character: 18)
        ),
        source: "DeadEnd",
        severity: 1,
        code: "Syntax"
      )
    )
  end

  it "no errors if source is empty" do
    source = Solargraph::Source.load_string("")
    reporter = Solargraph::DeadEnd::Reporter.new
    errors = reporter.diagnose(source, nil)

    expect(errors).to be_empty
  end

  it "no errors if there are no problems in source" do
    source = Solargraph::Source.load_string("def test_method; end")
    reporter = Solargraph::DeadEnd::Reporter.new
    errors = reporter.diagnose(source, nil)

    expect(errors).to be_empty
  end

  it "correct error for multi-line file" do
    source = Solargraph::Source.load_string(
      <<~SRC
        class Dog
          puts "test"
          def bark
            puts "test"
          end

          def another

          def my_method
          end
        end
      SRC
    )
    reporter = Solargraph::DeadEnd::Reporter.new
    errors = reporter.diagnose(source, nil)
    expect(errors).to include(
      {
        message: "Unmatched keyword, missing `end' ?\n   1  class Dog\n" \
                 "❯  7    def another\n  10    end\n  11  end\n",
        range: {
          start: {
            line: 6,
            character: 0
          },
          end: {
            line: 6,
            character: 14
          }
        },
        severity: 1,
        source: "DeadEnd",
        code: "Syntax"
      }
    )
  end

  it "correct number of errors" do
    source = Solargraph::Source.load_string(
      <<~SRC
        class Dog
          puts "test"
          def bark
            puts "test"
          end

          def another

          def my_method
          end
        end

        class Cat
          def meow
            [1,2,3].each do
          end
        end
      SRC
    )
    reporter = Solargraph::DeadEnd::Reporter.new
    errors = reporter.diagnose(source, nil)

    expect(errors.count).to eq(2)
  end
end
