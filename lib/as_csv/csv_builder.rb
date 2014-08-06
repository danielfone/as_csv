require "csv"

module AsCSV
  class CSVBuilder
    attr_reader :records, :options

    def initialize(records, options={})
      @records = Array(records)
      @options = options
      validate
    end

    def to_csv
      rows.collect { |row| CSV.generate_line row }.join
    end

    private

      def rows
        @rows ||= [headers] + data_rows
      end

      def headers
        @headers ||= csv_hashes.collect(&:keys).flatten.uniq
      end

      def data_rows
        @data_rows ||= csv_hashes.collect { |csv_hash| data_row csv_hash }
      end

      def validate
        validate_members
        validate_hashes
      end

      def validate_members
        if records.any? { |r| not r.respond_to? :as_csv }
          raise TypeError, 'Some elements do not respond to :as_csv'
        end
      end

      def validate_hashes
        csv_hashes.each do |hash|
          raise TypeError, "expected as_csv to return Hash" unless hash.is_a? Hash
        end
      end

      def csv_hashes
        @csv_hashes ||= records.collect { |r| r.as_csv(options) if r.respond_to? :as_csv }.compact
      end

      def data_row(csv_hash)
        headers.collect { |header| csv_hash[header] }
      end
  end
end
