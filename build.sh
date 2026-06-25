#!/bin/bash 
find post -name "*.tex"|while read tex;do
html="${tex%.tex}.html"
title=$(basename "${tex%.tex}")
dep=$(echo "$tex"|tr -cd '/'|wc -c)
pre=$(printf '../%.0s' $(seq 1 $dep))
pandoc "$tex" --katex --section-divs --lua-filter=theorem.lua --lua-filter=image-lazy.lua --syntax-highlighting=tango -o /tmp/body.html
cat > "$html" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${title} · KomariChika</title>
<link rel="stylesheet" href="${pre}s1.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css">
<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.js"
  onload="document.querySelectorAll('.math').forEach(function(el){try{katex.render(el.textContent,el,{displayMode:el.classList.contains('display'),throwOnError:false});}catch(e){console.error(e);}});"></script>
</head>
<body>
<header><nav><a href="${pre}index.html">Home</a></nav></header>
<main><article>
$(cat /tmp/body.html)
</article></main>
<footer>
        <div class="social-links">
            </div>
        <a href="https://github.com/zhanglyhub" style="font-weight: bold;">Github</a>
        <a href="https://x.com/Theshine891403" style="font-weight: bold;">twitter</a>
        <a href="xdefan101@gmail.com" style="font-weight: bold;">mail</a>
        <p>© 2026 KomariChika · <a href=" https://creativecommons.org/licenses/by-nc-sa/4.0/">CC BY-NC-SA 4.0</p>
    </footer>
</body>
</html>
EOF
done

LOG="post/life/log.md"
OUT="post/life/index.html"
if [ -f "$LOG" ]; then
  : > /tmp/life_entries.html          # 清空累积文件

  date=""
  body=""
  in_entry=0

  # 末尾补一个换行，确保最后一条能被收尾
  while IFS= read -r line || [ -n "$line" ]; do
    if [[ "$line" =~ ^:::[[:space:]]+(.+)$ ]]; then
      # 遇到 "::: 日期" —— 一条开始
      date="${BASH_REMATCH[1]}"
      body=""
      in_entry=1
    elif [[ "$line" == ":::" ]]; then
      # 遇到单独的 ":::" —— 一条结束，渲染它
      printf '%s' "$body" | pandoc --katex --syntax-highlighting=tango -o /tmp/entry.html
      {
        echo "<article class=\"log-entry\">"
        echo "<time>${date}</time>"
        cat /tmp/entry.html
        echo "</article>"
      } >> /tmp/life_entries.html
      in_entry=0
    elif [ "$in_entry" -eq 1 ]; then
      # 条目正文，逐行累积
      body+="${line}"$'\n'
    fi
  done < "$LOG"

  cat > "$OUT" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Life · KomariChika</title>
<link rel="stylesheet" href="../../s1.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css">
<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.js"
  onload="document.querySelectorAll('.math').forEach(function(el){try{katex.render(el.textContent,el,{displayMode:el.classList.contains('display'),throwOnError:false});}catch(e){console.error(e);}});"></script>
</head>
<body>
<header><nav><a href="../../index.html">Home</a></nav></header>
<main>
$(cat /tmp/life_entries.html)
</main>
<footer>
        <div class="social-links">
            </div>
        <a href="https://github.com/zhanglyhub" style="font-weight: bold;">Github</a>
        <a href="https://x.com/Theshine891403" style="font-weight: bold;">twitter</a>
        <a href="xdefan101@gmail.com" style="font-weight: bold;">mail</a>
        <p>© 2026 KomariChika · <a href=" https://creativecommons.org/licenses/by-nc-sa/4.0/">CC BY-NC-SA 4.0</p>
    </footer>
</body>
</html>
EOF
  echo "built $OUT"
fi
