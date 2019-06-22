class NilDog < Dog
  def reload; end;

  def errors
    super.tap do |e|
      unless e.include?(:id)
        e.add(:id, 'dog not found')
      end
    end
  end
end