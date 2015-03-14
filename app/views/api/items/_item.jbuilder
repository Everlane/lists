json.extract! item, :title, :content, :position
json.children item.children, partial: 'api/items/item', as: :item
