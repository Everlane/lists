json.id item.id
json.title item.title
json.content item.content
json.children do
  json.array!(item.children) do |item|
    json.partial! 'api/items/item', item: item
  end
end
