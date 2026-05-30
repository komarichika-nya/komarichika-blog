function Div(el)
  local envs = {theorem="Theorem", lemma="Lemma", proposition="Proposition"}
  for cls, label in pairs(envs) do
    if el.classes:includes(cls) then
      table.insert(el.content, 1,
        pandoc.Para(pandoc.Strong(label .. ". ")))
      el.classes:insert("theorem-box")
      return el
    end
  end
end