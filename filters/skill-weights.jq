def count(skills):
  reduce skills[] as $skill (
    {}; .[$skill] += 1
  );

def clamp(value; min; max):
  if value < min then min
  elif value > max then max
  else value
  end;

def ratio(counts; max):
  with_entries( .value |= (. / max | clamp(. ; 0.2; 1.0)) );

{
  skillWeights:
    .projects
    | map(.skills)
    | flatten
    | count(.)
    | to_entries
    | map(select(.value > 1))
    | sort_by(.value) | reverse
    | from_entries
}