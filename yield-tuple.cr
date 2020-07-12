def iterate
  yield ({10, 20})
end

iterate { |i, j| puts "(#{i}, #{j})" }
