# frozen_string_literal: true

module Solargraph
  module DeadEnd
    class Reporter < Solargraph::Diagnostics::Base
      def diagnose(source, _api_map)
        return [] if source.code.empty?

        search = ::DeadEnd::CodeSearch.new(source.code, record_dir: nil).call

        blocks = search.invalid_blocks

        return [] if blocks.empty?

        result = []
        blocks.each do |block|
          explain = ::DeadEnd::ExplainSyntax.new(
            code_lines: block.lines
          ).call

          lines = ::DeadEnd::CaptureCodeContext.new(
            blocks: block,
            code_lines: search.code_lines
          ).call

          document = ::DeadEnd::DisplayCodeWithLineNumbers.new(
            lines: lines,
            terminal: @terminal,
            highlight_lines: block.lines
          ).call

          result << error_output(explain, document, block)
        end

        result
      end

      private

      def error_output(explain, document, block)
        relevant_lines = block.lines.reject { |l| l.line.strip.empty? }
        {
          message: explain.errors.first + "\n" + document,
          range: {
            start: {
              line: relevant_lines.first.line_number - 1,
              character: 0
            },
            end: {
              line: relevant_lines.last.line_number - 1,
              character: relevant_lines.last.line.length
            }
          },
          severity: 1,
          source: "DeadEnd",
          code: "Syntax"
        }
      end
    end
  end
end
