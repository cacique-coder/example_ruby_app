module CsvSaver
  module Importable

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def import_sync(file)
        CsvSaver::Saver.new(self.to_s, values_form_file(file))
      end

      def import_async(file)
        CsvSaver::Worker.perform_async(self.to_s, values_from_file(file))
      end

      def csv_ignore_row(condition)
        @csv_ignore_row = condition
      end

      def csv_ignorable_row?(row)
        @csv_ignore_row ? @csv_ignore_row.call(row) : false
      end

      def csv_create_fields(row)
        @csv_create_fields = row
      end

      def csv_rename_headers(hash)
        @to_rename = hash
      end

      def csv_allow_headers(*keys)
        @allow_headers = keys
      end

      def csv_nested_multiple_values(options)
        @csv_nested_multiple_values = options
      end

      def csv_compress_fields(options)
        @csv_compress_fields = options
      end

      def csv_custom_values(options)
        @csv_custom_values = options
      end

      def get_csv_create_fields
        @csv_create_fields
      end

      def get_csv_rename_headers
        @to_rename
      end

      def get_csv_allow_headers
        @allow_headers
      end

      def get_csv_nested_multiple_values
        @csv_nested_multiple_values
      end

      def get_csv_compress_fields
        @csv_compress_fields
      end

      def get_csv_custom_values
        @csv_custom_values
      end

      def  values_from_file(file)
        values = []
        CSV.foreach(file.path, headers: true) do |row|
          values << row.to_hash
        end
        values
      end
    end
  end
end
