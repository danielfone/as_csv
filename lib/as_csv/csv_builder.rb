module AsCSV
  class CSVBuilder
    attr_reader :records, :options

    def initialize(records, options={})
      @records = [*records]
      @options = options
    end

    def to_csv
      rows.collect { |row| CSV.generate_line row }.join if valid?
    end

    def rows
      @rows ||= [headers] + data_rows if valid?
    end

    def headers
      @headers ||= csv_hashes.collect(&:keys).flatten.uniq if valid?
    end

    def data_rows
      @data_rows ||= csv_hashes.collect { |csv_hash| data_row csv_hash } if valid?
    end

    def valid?
      csv_hashes.any? && validate_hashes!
    end

    private

      def validate_hashes!
        csv_hashes.each do |hash|
          raise TypeError, "expected as_csv to return Hash" unless hash.is_a? Hash
        end
      end

      def csv_hashes
        @csv_hashes ||= records.collect { |r| r.as_csv if r.respond_to? :as_csv }.compact
      end

      def data_row(csv_hash)
        headers.collect { |header| csv_hash[header] }
      end
  end  
end
