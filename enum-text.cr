enum Color : Int8
  Gray
  Red

  # Does not compile. There is no previous definition, because the
  # parameterless to_s is being overridden here, not redefined.
  def to_s
    previous_def.downcase
  end

  def to_s(io)
    io << to_s
  end
end

puts Color::Gray
