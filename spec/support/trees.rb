module Trees
  def expect_node_key_data(node, key, data)
    expect(node.full_key(root: false)).to eq key
    expect(node.data).to eq adjust_source_occurrences(data)
  end

  # adjust position to account for \r on Windows
  def adjust_source_occurrences(data)
    if Gem.win_platform?
      data = data.dup
      data[:source_occurrences].map! { |occ| adjust_source_occurrence occ }
    end
    data
  end

  # adjust position to account for \r on Windows
  def adjust_source_occurrence(occurrence)
    occurrence.dup.tap { |o| o[:pos] += o[:line_num] - 1 }
  end


  def build_tree(hash)
    I18n::Tasks::Data::Tree::Siblings.from_nested_hash(hash)
  end

  def build_node(attr = {})
    raise 'invalid node (more than 1 root)' if attr.size > 1
    key, value = attr.first
    I18n::Tasks::Data::Tree::Node.from_key_value(key, value)
  end

  def new_node(attr = {})
    I18n::Tasks::Data::Tree::Node.new(attr)
  end
end