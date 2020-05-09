if @new_post.present? # @new_messageに中身があれば
    json.array! @new_post # 配列かつjson形式で@new_messageを返す
end