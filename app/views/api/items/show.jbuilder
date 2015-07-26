json.extract! @item, :title, :content, :position, :parent_id
json.children do
  json.array!(@item.children) do |item|
    json.partial! 'api/items/item', item: item
  end
end
