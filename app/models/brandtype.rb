class Brandtype < ActiveHash::Base
  self.data = [
      {id: 0, name: '---'},
      {id: 1, name: 'シャネル'}, {id: 2, name: 'ナイキ'}, {id: 3, name: 'ルイヴィトン'},
      {id: 4, name: 'シュプリーム'}
  ]
end