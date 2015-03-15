item ||= @item

json.extract! item, :id, :title, :content
json.children item.children, partial: 'api/items/item', as: :item
