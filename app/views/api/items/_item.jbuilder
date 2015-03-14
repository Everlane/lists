json.extract! item, :title, :content
json.children item.children, partial: 'api/items/item', as: :item
