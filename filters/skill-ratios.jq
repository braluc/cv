def clamp(value; min; max):
  if value < min then min
  elif value > max then max
  else value
  end;

{
  skillRatios:
    .["skillWeights"]
    | to_entries
    | (
        . as $entries
        | ($entries | max_by(.value) | .value) as $max
        | $entries | map({key: .key, value: (.value / $max | clamp(. ; 0.3; 1.0))})
      )
    | from_entries
}
