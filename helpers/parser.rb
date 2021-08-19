module Parser
  def to_json_arr(arr)
    arr.map(&:to_json)
  end
end
