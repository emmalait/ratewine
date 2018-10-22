json.array!(@ratings) do |rating|
  json.extract! rating, :id, :score, :wine
end
