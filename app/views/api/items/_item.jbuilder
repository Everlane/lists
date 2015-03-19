item ||= @item

json.extract! item, :id, :title, :content, :position
json.children item.children, partial: 'api/items/item', as: :item
