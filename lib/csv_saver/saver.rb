class Saver

  attr_reader :klass, :values, :id_errors
  def initialize(class_name, file)
    @klass = Object.const_get(klass_string)
    @values = values_from_file(file)
    @id_errors = []
  end

  def execute
    values.each do |info_hash|
      next if ignore_row(info_hash)
      instance = @klass.find_by_id(info_hash[:id])
      if instance
        instance.update(info_hash)
      else
        instance = @klass.create(info_hash)
      end
      if !Rails.env.test? && instance.errors.any?
        ids_error << {info_hash[:id] => instance.errors.full_messages}
      end
    end
    if ids_error.any?
      logger.info( "----- FINAL START -----")
      logger.info( ids_error.inspect)
      logger.info( "------ FINAL END ------")
    end
  end

  def values_from_file(values)
    values.map{|row| create_row(row) }
  end

  def create_row(hash)
    hash = sym_keys(hash)
    hash = rename_hash(hash)
    hash = replaces_values_row(hash)
    hash = create_fields(hash)
    row = remove_values(hash)
    row.merge( nested_values(hash) )
  end

  def ignore_row(row)
    @klass.csv_ignorable_row?(row)
  end
  def create_fields(hash)
    return hash if @klass.get_csv_create_fields.nil?
    @klass.get_csv_create_fields.each do |key,value|
      hash[key] = value.call(hash)
    end
    hash
  end

  def nested_values(hash)
    return {} if @klass.get_csv_nested_multiple_values.nil?
    keys = @klass.get_csv_nested_multiple_values.keys
    hash = create_nested_multiple_attributes_values(hash,keys )
    hash.select{|k,value| !k.empty?}
  end

  def create_nested_multiple_attributes_values(row,keys)
    keys.inject({}) do |hash,key|
      value = replaces_values_inner(row,key)
      hash[ "#{key}_attributes".to_sym ] = value.flatten if value
      hash
    end
  end

  def replaces_values_row(hash)
    return hash if @klass.get_csv_custom_values.nil?
    @klass.get_csv_custom_values.each do |key,value|
      hash[key] = value.call(hash[key])
    end
    hash
  end

  def replaces_values_inner(row,key)
    return nil if @klass.get_csv_nested_multiple_values[key].empty?
    row[key] = []
    @klass.get_csv_nested_multiple_values[key].map do |key_lambda|
      row[key] << row[key_lambda]
    end
    row[key]
  end

  def rename_hash(hash)
    return hash if @klass.get_csv_rename_headers.nil?
    @klass.get_csv_rename_headers.each do |old,new_value|
      old = old
      hash[new_value] = hash[old]
      hash.delete(old)
    end
    hash
  end

  def sym_keys(hash)
    new_hash = {}
    hash.each_pair do |k,v|
     new_hash.merge!({k.downcase.gsub(' ','_').to_sym => v})
    end
    new_hash
  end

  def remove_values(hash)
    keys_to_remove = hash.keys - @klass.get_csv_allow_headers
    hash.select{ |k,_| !keys_to_remove.include?(k) }
  end
end
