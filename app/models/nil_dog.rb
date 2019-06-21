class NilDog < Dog
  def reload; end;

  def errors
    super.tap do |e|
      e.add(:id, 'dog not found')
    end
  end
end