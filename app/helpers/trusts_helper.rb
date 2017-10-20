module TrustsHelper
  def get_trust_theme_message(name)
    %W(
      #{name}さんの強みは？
      #{name}さんの性格は？
      #{name}さんとの関係は？
      #{name}さんの尊敬しているところは？
      #{name}さんの弱みをしいてあげるなら？
      #{name}さんは何をしているひと？
      #{name}さんのスキルは？
      #{name}さんをあなたが採用するなら、どんなポジションにしますか？
    ).sample
  end
end
