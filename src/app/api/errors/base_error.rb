# frozen_string_literal: true

module API
  module Errors
    class BaseError < StandardError
      attr_reader :attributes, :meta, :origin

      def initialize(origin = nil)
        @origin = origin
      end

      def code
        raise NotImplementedError, 'method #code has to be implemented'
      end

      def message
      end

      def to_h
        {
          code: code,
          attributes: attributes,
          meta: meta
        }.compact
      end
    end
  end
end
