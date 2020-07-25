def odd_squares(values)
  values.map do |value|
    next if value.even?
    value**2
  end
end

pp odd_squares(1..10).to_a
