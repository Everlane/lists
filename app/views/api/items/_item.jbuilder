json.extract! item, :id, :title, :content, :position
json.children do
  json.array!(item.children) do |item|
    json.partial! 'api/items/item', item: item
  end
end
