class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.attachment :avatar
      t.string :email
      t.string :username
      t.string :nickname
      t.string :mobile
      t.string :password
      t.string :salt
      t.string :province
      t.string :city
      t.string :site
      t.string :resume
      t.string :domain
      t.string :profession # 职业
      t.date   :duty
      t.boolean :gender
      t.integer :warrant, default: 5 # 授权 暂时保留 可删除 因为上传图片时要求必选
      t.boolean :admin, default: 0 # 管理员
      t.boolean :photographer, default: 0 # 摄影师


      t.integer :nots_count, default: 0 # 通知数量
      t.integer :fols_count, default: 0 # 粉丝数量
      t.integer :msgs_count, default: 0 # 私信数量
      t.integer :phos_count, default: 0 # 图片数量
      t.integer :albs_count, default: 0 # 相册数量
      t.integer :wors_count, default: 0 # 作品数量
      t.integer :liks_count, default: 0 # 喜欢数量
      t.integer :stos_count, default: 0 # 收藏数量
      # ... 推荐数 自荐数 精选数 浏览数
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
