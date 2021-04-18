class GrpcDataTransformers

  CUSTOM_ENCODED_TYPES = {}.freeze

  def self.hash_to_grpc_object(source_hash, message_class)
    final_hash = source_hash.dup
    serialize_with_descriptor(message_class.descriptor, final_hash )
  end

  def self.serialize_with_descriptor(descriptor_class, hash_value, render_as_hash: false)
    hash_value = hash_value.deep_symbolize_keys if hash_value.is_a?(Hash)
    new_hash = {}
    return hash_value if descriptor_class.nil?
    available_keys = hash_value.keys
    descriptor_class.entries.each do |entry|
      is_key_present = available_keys.include?(entry.name.to_sym)
      value =  serialize_with_field_descriptor(entry, hash_value[entry.name.to_sym], is_key_present: is_key_present)
      unless value.nil?
        new_hash[entry.name] = value
      end
    end

    render_as_hash ? new_hash : descriptor_class.msgclass.new(new_hash)
  end

  def self.serialize_with_field_descriptor(field_descriptor, value, is_key_present: true)
    return value if field_descriptor.nil?

    if field_descriptor.label == :repeated
      return serialize_with_repeated_field(field_descriptor, value)
    end
    if field_descriptor.type == :message
      custom_encode = CUSTOM_ENCODED_TYPES[field_descriptor.subtype.msgclass]
      if custom_encode
        return field_descriptor.subtype.msgclass.encode_value(value, is_key_present)
      end
      if field_descriptor.subtype.is_a?(Google::Protobuf::Descriptor)
        return serialize_with_descriptor(field_descriptor.subtype, value) unless value.nil?
      end

      return field_descriptor.subtype.msgclass.new(value) unless value.nil?

    end
    value
  end


end