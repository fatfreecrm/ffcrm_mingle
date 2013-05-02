MingleSettings = {
  'url' => '',
  'username' => '',
  'password' => '',
  'projects' => 'proj1, proj2',
  'card_type' => 'Story',
  'fields' => 'number, name, status, owner',
}.with_indifferent_access

Setting[:mingle] = MingleSettings
