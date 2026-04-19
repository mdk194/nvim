def hex_to_rgb(h):
    h = h.lstrip('#'); return tuple(int(h[i:i+2], 16) / 255.0 for i in (0, 2, 4))
def linearize(c):
    return c / 12.92 if c <= 0.04045 else ((c + 0.055) / 1.055) ** 2.4
def luminance(hc):
    r, g, b = hex_to_rgb(hc); return 0.2126 * linearize(r) + 0.7152 * linearize(g) + 0.0722 * linearize(b)
def cr(c1, c2):
    l1, l2 = luminance(c1), luminance(c2)
    if l1 < l2: l1, l2 = l2, l1
    return (l1 + 0.05) / (l2 + 0.05)
def rs(c, bg): return f"{cr(c, bg):.1f}:1"

def gen(sn, var, p, k, uf):
    dk = var == "dark"
    bg=p["bg"];fg=p["fg"];cl=p["cursorline"]
    cb="#222" if dk else "#ddd";cf="#ccc" if dk else "#333";cbd="#333" if dk else "#c8c0b4"
    nb=cl if dk else "#e8e4dc"
    cub=k.get("cursor",fg);cut=k.get("cursor_text_color",bg)
    tbb=k.get("tab_bar_background",uf);atb=k.get("color11",p["yellow"]);atf=bg
    itb=tbb;itf=k.get("inactive_tab_foreground",fg)
    cwb=fg;cwf=bg;sb=k.get("active_border_color","#bda04f")
    fb=cl;pb=cl;pbd=p["keyword"];ps=p["context"]
    pr=""
    for n in ["bg","cursorline","comment","border","fg","red","yellow","blue","tan","keyword","diff_bg","diff_del","diff_chg","diff_fg","context"]:
        c=p[n];r1=rs(c,bg);r2=rs(c,uf)
        pr+=f'<tr><td class="pname">{n}</td><td class="phex"><code>{c}</code></td><td class="pbg" style="background:{bg};"><span style="color:{c};">The quick brown fox</span></td><td class="pratio">{r1}</td><td class="pbg" style="background:{uf};"><span style="color:{c};">The quick brown fox</span></td><td class="pratio">{r2}</td></tr>\n'
    an=["black","red","green","yellow","blue","magenta","cyan","white"];bn=["br black","br red","br green","br yellow","br blue","br magenta","br cyan","br white"]
    def ar(cs,ns):
        o=""
        for c,n in zip(cs,ns): o+=f'<td class="ansi-cell"><div class="ansi-preview" style="background:{bg};color:{c};">{n}</div><div class="ansi-hex">{c}</div><div class="ansi-ratio">{rs(c,bg)}</div></td>'
        return o
    al=[k[f"color{i}"] for i in range(8)];ah=[k[f"color{i}"] for i in range(8,16)]
    vi=p.get("visual",cl);fn=f"{sn} colorscheme ({var})";st=f"{sn} &middot; nvim &middot; kitty &middot; git &middot; dir_colors"
    tb=f'<div style="background:{tbb};display:flex;align-items:center;font-family:\'SF Mono\',\'Fira Code\',monospace;font-size:12px;padding:0;height:24px;border-radius:0 0 3px 3px;overflow:hidden;"><span style="background:{itb};color:{itf};padding:2px 10px;font-weight:bold;"> 1 </span><span style="background:{atb};color:{atf};padding:2px 10px;font-weight:bold;"> 2 </span><span style="background:{itb};color:{itf};padding:2px 10px;font-weight:bold;"> 3 </span><span style="flex:1;"></span><span style="color:{fg};padding:0 8px;font-size:11px;">nvim settings.lua</span><span style="background:{cwb};color:{cwf};padding:2px 10px;font-size:11px;"> ~/nvim </span></div>'
    def dm(t):return f'<span style="display:block;background:{p["diff_del"]};color:{p["red"]};padding:0 4px;">{t}</span>'
    def dp(t):return f'<span style="display:block;background:{p["diff_bg"]};color:{p["blue"]};padding:0 4px;">{t}</span>'
    return f'''<!DOCTYPE html><html lang="en"><head><meta charset="utf-8"><title>{fn} — Full Palette Preview</title>
<style>*{{margin:0;padding:0;box-sizing:border-box}}body{{background:{cb};color:{cf};font-family:system-ui,sans-serif;padding:0 0 3rem}}nav{{position:sticky;top:0;z-index:10;background:{nb};border-bottom:1px solid {cbd};padding:6px 16px;display:flex;gap:16px;font-size:13px}}nav a{{color:{p["blue"]};text-decoration:none}}h1{{text-align:center;padding:20px 16px 4px;font-size:20px;color:{fg}}}h1 small{{font-size:12px;color:{p["border"]};display:block;margin-top:3px}}h2{{color:{p["keyword"]};font-size:15px;margin:0 0 10px;padding-bottom:3px;border-bottom:1px solid {cbd}}}section{{max-width:1300px;margin:0 auto;padding:18px 16px}}.ptable{{width:100%;border-collapse:collapse;font-size:12px;font-family:"SF Mono","Fira Code",monospace}}.ptable th{{text-align:left;padding:3px 8px;color:{p["border"]};border-bottom:1px solid {cbd};font-weight:normal;font-size:11px}}.ptable td{{padding:3px 8px;border-bottom:1px solid {nb}}}.pname{{color:{p["tan"]};width:80px}}.phex{{width:70px}}.phex code{{color:{fg};font-size:11px}}.pbg{{width:200px;padding:4px 10px !important;border-radius:3px;font-size:12px}}.pratio{{color:{p["border"]};width:50px;text-align:right;font-size:11px}}.atable{{border-collapse:collapse;width:100%;font-size:11px;font-family:"SF Mono","Fira Code",monospace;table-layout:fixed}}.atable th{{padding:3px;color:{p["border"]};font-weight:normal;text-align:center;border-bottom:1px solid {cbd}}}.ansi-cell{{text-align:center;padding:6px 2px;border-bottom:1px solid {nb}}}.ansi-preview{{display:inline-block;padding:2px 8px;border-radius:3px;font-size:13px;font-weight:600;margin:3px 0;min-width:50px}}.ansi-hex{{color:{fg};font-size:10px}}.ansi-ratio{{color:{p["border"]};font-size:9px}}.code-grid{{display:grid;grid-template-columns:1fr 1fr;gap:10px}}.code-wrap{{border:1px solid {cbd};border-radius:5px;overflow:hidden;display:flex;flex-direction:column;position:relative}}pre.code{{background:{bg};padding:10px 12px;overflow-x:auto;font-size:12px;line-height:1.6;font-family:"SF Mono","Fira Code",monospace;margin:0;white-space:pre;flex:1}}pre.code .lang{{display:block;color:{p["border"]};font-size:9px;text-transform:uppercase;letter-spacing:1px;margin-bottom:4px}}.term-wrap{{border:1px solid {cbd};border-radius:5px;overflow:hidden;display:flex;flex-direction:column}}.split-container{{display:flex;flex:1;min-height:0}}.split-left{{flex:1;overflow:hidden}}.split-right{{flex:1;overflow:hidden}}.split-border{{width:1px;background:{sb};flex-shrink:0}}pre.term{{padding:10px 12px;overflow-x:auto;font-size:12px;line-height:1.6;font-family:"SF Mono","Fira Code",monospace;margin:0;white-space:pre;flex:1}}@keyframes blink{{0%,49%{{background:{cub};color:{cut}}}50%,100%{{background:transparent;color:inherit}}}}.cur{{animation:blink 1s step-end infinite}}.sel{{background:{vi}}}.pmenu{{position:absolute;background:{pb};border:1px solid {pbd};border-radius:3px;font-family:"SF Mono","Fira Code",monospace;font-size:12px;line-height:1.6;padding:2px 0;z-index:5}}.pmenu-item{{padding:0 8px;color:{fg};white-space:nowrap}}.pmenu-sel{{background:{ps}}}.pmenu-match{{color:{p["yellow"]};font-weight:bold}}.float{{position:absolute;background:{fb};border:1px solid {pbd};border-radius:3px;font-family:"SF Mono","Fira Code",monospace;font-size:11px;line-height:1.5;padding:6px 10px;z-index:5;max-width:320px}}.float-kw{{color:{p["keyword"]};font-weight:bold}}.float-type{{color:{p["yellow"]}}}.float-comment{{color:{p["comment"]};font-style:italic}}</style></head><body>
<nav><a href="#palette">Palette</a> <a href="#code">Code</a> <a href="#ansi16">ANSI 16</a> <a href="#terminal">Terminal</a></nav>
<h1>{fn}<small>{st}</small></h1>
<section id="palette"><h2>Palette</h2><table class="ptable"><tr><th>Name</th><th>Hex</th><th>on focused {bg}</th><th></th><th>on unfocused {uf}</th><th></th></tr>{pr}</table></section>
<section id="code"><h2>Code Preview (treesitter)</h2><div class="code-grid">
<div class="code-wrap"><pre class="code"><span class="lang">rust</span><span style="color:{p["comment"]};font-style:italic;">// A simple HTTP handler</span>
<span style="color:{p["keyword"]};">use</span> <span style="color:{p["yellow"]};">std</span><span style="color:{fg};">::</span><span style="color:{p["yellow"]};">collections</span><span style="color:{fg};">::</span><span style="color:{p["yellow"]};">HashMap</span><span style="color:{fg};">;</span>

<span style="color:{p["keyword"]};">pub</span> <span style="color:{p["keyword"]};">struct</span> <span style="color:{p["yellow"]};">Config</span> <span style="color:{fg};">{{</span>
    <span style="color:{fg};">name</span><span style="color:{fg};">:</span> <span style="color:{p["yellow"]};">String</span><span style="color:{fg};">,</span>
    <span style="color:{fg};">port</span><span style="color:{fg};">:</span> <span style="color:{p["yellow"]};">u16</span><span style="color:{fg};">,</span>
<span style="color:{fg};">}}</span>

<span style="color:{p["keyword"]};">impl</span> <span style="color:{p["yellow"]};">Config</span> <span style="color:{fg};">{{</span>
    <span style="color:{p["keyword"]};">pub</span> <span style="color:{p["keyword"]};">fn</span> <span style="color:{p["tan"]};">new</span><span style="color:{fg};">(</span><span style="color:{fg};font-weight:bold;">name</span><span style="color:{fg};">:</span> &amp;<span style="color:{p["yellow"]};">str</span><span style="color:{fg};">)</span> -&gt; <span style="color:{p["yellow"]};">Self</span> <span style="color:{fg};">{{</span>
        <span style="color:{p["yellow"]};">Self</span> <span style="color:{fg};">{{</span>
            <span style="color:{fg};">name</span><span style="color:{fg};">:</span> <span style="color:{fg};font-weight:bold;">name</span><span style="color:{fg};">.</span><span style="color:{p["tan"]};">to_<span class="cur">s</span></span>
            <span style="color:{fg};">port</span><span style="color:{fg};">:</span> <span style="color:{p["keyword"]};">8080</span><span style="color:{fg};">,</span>
        <span style="color:{fg};">}}</span>
    <span style="color:{fg};">}}</span>
<span class="sel">
    <span style="color:{p["keyword"]};">pub</span> <span style="color:{p["keyword"]};">fn</span> <span style="color:{p["tan"]};">addr</span><span style="color:{fg};">(&amp;</span><span style="color:{p["keyword"]};">self</span><span style="color:{fg};">)</span> -&gt; <span style="color:{p["yellow"]};">String</span> <span style="color:{fg};">{{</span>
        <span style="color:{p["red"]};">format!</span><span style="color:{fg};">(</span><span style="color:{p["blue"]};">"{{}}:{{}}"</span><span style="color:{fg};">)</span></span>
    <span style="color:{fg};">}}</span>
<span style="color:{fg};">}}</span></pre>
<div class="pmenu" style="left:195px;top:205px;"><div class="pmenu-item"><span class="pmenu-match">to_s</span>tring</div><div class="pmenu-item pmenu-sel"><span class="pmenu-match">to_s</span>tring_lossy</div><div class="pmenu-item">to_owned</div><div class="pmenu-item">to_vec</div></div>
{tb}</div>
<div class="code-wrap"><pre class="code"><span class="lang">python</span><span style="color:{p["comment"]};font-style:italic;"># Data processing pipeline</span>
<span style="color:{p["keyword"]};">from</span> <span style="color:{p["yellow"]};">dataclasses</span> <span style="color:{p["keyword"]};">import</span> <span style="color:{p["tan"]};">dataclass</span>
<span style="color:{p["keyword"]};">from</span> <span style="color:{p["yellow"]};">typing</span> <span style="color:{p["keyword"]};">import</span> <span style="color:{p["tan"]};">Optional</span>

<span style="color:{p["keyword"]};">@</span><span style="color:{p["tan"]};">dataclass</span>
<span style="color:{p["keyword"]};">class</span> <span style="color:{p["yellow"]};">Record</span><span style="color:{fg};">:</span>
    <span style="color:{fg};">name</span><span style="color:{fg};">:</span> <span style="color:{p["yellow"]};">str</span>
    <span style="color:{fg};">value</span><span style="color:{fg};">:</span> <span style="color:{p["yellow"]};">float</span>
    <span style="color:{fg};">tag</span><span style="color:{fg};">:</span> <span style="color:{p["yellow"]};">Optional</span><span style="color:{fg};">[</span><span style="color:{p["yellow"]};">str</span><span style="color:{fg};">]</span> <span style="color:{fg};">=</span> <span style="color:{p["keyword"]};">None</span>

<span style="color:{p["keyword"]};">def</span> <span style="color:{p["tan"]};">process</span><span style="color:{fg};">(</span><span style="color:{fg};font-weight:bold;">records</span><span style="color:{fg};">:</span> <span style="color:{p["yellow"]};">list</span><span style="color:{fg};">[</span><span style="color:{p["yellow"]};">Record</span><span style="color:{fg};">]) -&gt;</span> <span style="color:{p["yellow"]};"><span class="cur">d</span>ict</span><span style="color:{fg};">:</span>
    <span style="color:{fg};">result</span> <span style="color:{fg};">=</span> <span style="color:{fg};">{{}}</span>
    <span style="color:{p["yellow"]};">for</span> <span style="color:{fg};">rec</span> <span style="color:{p["yellow"]};">in</span> <span style="color:{fg};font-weight:bold;">records</span><span style="color:{fg};">:</span>
        <span style="color:{p["keyword"]};">if</span> <span style="color:{fg};">rec</span><span style="color:{fg};">.</span><span style="color:{fg};">value</span> <span style="color:{fg};">&gt;</span> <span style="color:{p["keyword"]};">0</span><span style="color:{fg};">:</span>
            <span style="color:{fg};">result</span><span style="color:{fg};">[</span><span style="color:{fg};">rec</span><span style="color:{fg};">.</span><span style="color:{fg};">name</span><span style="color:{fg};">]</span> <span style="color:{fg};">=</span> <span style="color:{fg};">rec</span><span style="color:{fg};">.</span><span style="color:{fg};">value</span>
    <span style="color:{p["keyword"]};">return</span> <span style="color:{fg};">result</span></pre>
<div class="float" style="left:85px;top:185px;"><div><span class="float-kw">class</span> <span class="float-type">dict</span>(<span class="float-type">**kwargs</span>)</div><div style="margin-top:4px;"><span class="float-comment">dict() -> new empty dictionary</span></div><div><span class="float-comment">dict(mapping) -> new dictionary</span></div><div><span class="float-comment">initialized from a mapping object</span></div></div>
{tb}</div>
<div class="code-wrap"><pre class="code"><span class="lang">go</span><span style="color:{p["comment"]};font-style:italic;">// Package server provides HTTP handlers</span>
<span style="color:{p["keyword"]};">package</span> <span style="color:{fg};">server</span>

<span style="color:{p["keyword"]};">import</span> <span style="color:{fg};">(</span>
    <span style="color:{p["blue"]};">"fmt"</span>
    <span style="color:{p["blue"]};">"net/http"</span>
<span style="color:{fg};">)</span>

<span style="color:{p["keyword"]};">type</span> <span style="color:{p["yellow"]};">Handler</span> <span style="color:{p["keyword"]};">struct</span> <span style="color:{fg};">{{</span>
    <span style="color:{fg};">Port</span> <span style="color:{p["yellow"]};">int</span>
<span style="color:{fg};">}}</span>
<span class="sel">
<span style="color:{p["keyword"]};">func</span> <span style="color:{fg};">(</span><span style="color:{fg};font-weight:bold;">h</span> *<span style="color:{p["yellow"]};">Handler</span><span style="color:{fg};">)</span> <span style="color:{p["tan"]};">Serve<span class="cur">H</span>TTP</span><span style="color:{fg};">(</span><span style="color:{fg};font-weight:bold;">w</span> <span style="color:{p["yellow"]};">http.ResponseWriter</span><span style="color:{fg};">,</span> <span style="color:{fg};font-weight:bold;">r</span> *<span style="color:{p["yellow"]};">http.Request</span><span style="color:{fg};">)</span> <span style="color:{fg};">{{</span>
    <span style="color:{p["red"]};">fmt</span><span style="color:{fg};">.</span><span style="color:{p["tan"]};">Fprintf</span><span style="color:{fg};">(</span><span style="color:{fg};font-weight:bold;">w</span><span style="color:{fg};">,</span> <span style="color:{p["blue"]};">"port: %d"</span><span style="color:{fg};">,</span> <span style="color:{fg};font-weight:bold;">h</span><span style="color:{fg};">.</span><span style="color:{fg};">Port</span><span style="color:{fg};">)</span></span>
<span style="color:{fg};">}}</span></pre>
{tb}</div>
<div class="code-wrap"><pre class="code"><span class="lang">typescript</span><span style="color:{p["comment"]};font-style:italic;">// User management module</span>
<span style="color:{p["keyword"]};">interface</span> <span style="color:{p["yellow"]};">User</span> <span style="color:{fg};">{{</span>
  <span style="color:{fg};">id</span><span style="color:{fg};">:</span> <span style="color:{p["yellow"]};">number</span><span style="color:{fg};">;</span>
  <span style="color:{fg};">name</span><span style="color:{fg};">:</span> <span style="color:{p["yellow"]};">string</span><span style="color:{fg};">;</span>
  <span style="color:{fg};">role</span><span style="color:{fg};">:</span> <span style="color:{p["blue"]};">"admin"</span> <span style="color:{fg};">|</span> <span style="color:{p["blue"]};">"user"</span><span style="color:{fg};">;</span>
<span style="color:{fg};">}}</span>
<span class="sel">
<span style="color:{p["keyword"]};">const</span> <span style="color:{p["tan"]};">getAdmins</span> <span style="color:{fg};">=</span> <span style="color:{p["keyword"]};">async</span> <span style="color:{fg};">(</span><span style="color:{fg};font-weight:bold;">users</span><span style="color:{fg};">:</span> <span style="color:{p["yellow"]};">User</span><span style="color:{fg};">[])</span> : <span style="color:{p["yellow"]};">Promise</span><span style="color:{fg};">&lt;</span><span style="color:{p["yellow"]};">User</span><span style="color:{fg};">[]&gt;</span> <span style="color:{fg};">=&gt;</span> <span style="color:{fg};">{{</span></span>
  <span style="color:{p["keyword"]};">const</span> <span style="color:{fg};">result</span> <span style="color:{fg};">=</span> <span style="color:{fg};font-weight:bold;">users</span><span style="color:{fg};">.</span><span style="color:{p["tan"]};">filter</span><span style="color:{fg};">((</span><span style="color:{fg};font-weight:bold;">u</span><span style="color:{fg};">)</span> <span style="color:{fg};">=&gt;</span> <span style="color:{fg};">{{</span>
    <span style="color:{p["keyword"]};">return</span> <span style="color:{fg};font-weight:bold;">u</span><span style="color:{fg};">.</span><span style="color:{fg};">role</span> <span style="color:{fg};">===</span> <span style="color:{p["blue"]};">"admin"</span>
  <span style="color:{fg};">}})</span>
  <span style="color:{p["tan"]};">console</span><span style="color:{fg};">.</span><span style="color:{p["tan"]};">log</span><span style="color:{fg};">(</span><span style="color:{p["blue"]};">`Found ${{</span><span style="color:{fg};">result</span><span style="color:{fg};">.</span><span style="color:{fg};">length</span><span style="color:{p["blue"]};"}} admins`</span><span style="color:{fg};">)</span>
  <span style="color:{p["keyword"]};">return</span> <span style="color:{fg};"><span class="cur">r</span>esult</span>
<span style="color:{fg};">}}</span></pre>
{tb}</div></div></section>
<section id="ansi16"><h2>Terminal 16 Colors</h2><table class="atable"><tr><th>color0</th><th>color1</th><th>color2</th><th>color3</th><th>color4</th><th>color5</th><th>color6</th><th>color7</th></tr><tr>{ar(al,an)}</tr></table><div style="height:12px"></div><table class="atable"><tr><th>color8</th><th>color9</th><th>color10</th><th>color11</th><th>color12</th><th>color13</th><th>color14</th><th>color15</th></tr><tr>{ar(ah,bn)}</tr></table></section>
<section id="terminal"><h2>Terminal &amp; Git Diff</h2><div class="term-wrap"><div class="split-container"><div class="split-left"><pre class="term" style="background:{bg};height:100%;"><span style="color:{p["border"]};">user@host</span><span style="color:{fg};">:</span><span style="color:{k["color4"]};">~/projects</span><span style="color:{fg};">$ </span><span style="color:{fg};">ls -la</span>
<span style="color:{p["border"]};">drwxr-xr-x  user group  4096 Apr  1 </span><span style="color:{p["yellow"]};font-weight:bold;">src/</span>
<span style="color:{p["border"]};">drwxr-xr-x  user group  4096 Apr  1 </span><span style="color:{p["yellow"]};font-weight:bold;">docs/</span>
<span style="color:{p["border"]};">-rw-r--r--  user group  2048 Apr  1 </span><span style="color:{p["tan"]};">README.md</span>
<span style="color:{p["border"]};">-rw-r--r--  user group   512 Apr  1 </span><span style="color:{p["tan"]};">config.toml</span>
<span style="color:{p["border"]};">-rwxr-xr-x  user group   384 Apr  1 </span><span style="color:{fg};">run.sh</span>
<span style="color:{p["border"]};">-rw-r--r--  user group   48K Apr  1 </span><span style="color:{p["comment"]};">screenshot.png</span>
<span style="color:{p["border"]};">-rw-r--r--  user group  120M Apr  1 </span><span style="color:{p["border"]};">video.mp4</span>
<span style="color:{p["border"]};">-rw-r--r--  user group   32K Apr  1 </span><span style="color:{p["keyword"]};font-weight:bold;font-style:italic;">archive.tar.gz</span>
<span style="color:{p["border"]};">lrwxrwxrwx  user group    24 Apr  1 </span><span style="color:{p["diff_fg"]};font-weight:bold;">latest -> releases/v2.1</span>
<span style="color:{p["border"]};">lrwxrwxrwx  user group    18 Apr  1 </span><span style="color:{p["red"]};">broken -> /no/such/path</span>

<span style="color:{p["border"]};">user@host</span><span style="color:{fg};">:</span><span style="color:{k["color4"]};">~/projects</span><span style="color:{fg};">$ </span><span style="color:{fg};">git status</span>
<span style="color:{fg};">On branch </span><span style="color:{p["comment"]};">main</span>
<span style="color:{fg};">Changes not staged for commit:</span>
  <span style="color:{p["diff_fg"]};">modified:   src/main.rs</span>
  <span style="color:{p["diff_fg"]};">modified:   src/config.rs</span>
<span style="color:{fg};">Untracked files:</span>
  <span style="color:{p["red"]};">src/new_module.rs</span>

<span style="color:{p["border"]};">user@host</span><span style="color:{fg};">:</span><span style="color:{k["color4"]};">~/projects</span><span style="color:{fg};">$ </span><span class="cur"> </span>
</pre></div><div class="split-border"></div><div class="split-right"><pre class="term" style="background:{uf};height:100%;"><span style="color:{p["yellow"]};">diff --git a/src/config.rs</span>
<span style="color:{p["yellow"]};">index 3a1b2c4..5d6e7f8</span>
<span style="color:{p["yellow"]};">--- a/src/config.rs</span>
<span style="color:{p["yellow"]};">+++ b/src/config.rs</span>
<span style="color:{p["diff_fg"]};font-weight:bold;">@@ -12,7 +12,9 @@</span>
<span style="color:{fg};">     Self {{</span>
<span style="color:{fg};">         name: name.into(),</span>
{dm("-        port: 8080,")}{dp("+        port: c.port(8080),")}{dp("+        host: c.host(),")}<span style="color:{fg};">     }}</span>
<span style="color:{fg};"> }}</span>

<span style="color:{p["yellow"]};">diff --git a/src/main.rs</span>
<span style="color:{p["yellow"]};">--- a/src/main.rs</span>
<span style="color:{p["yellow"]};">+++ b/src/main.rs</span>
<span style="color:{p["diff_fg"]};font-weight:bold;">@@ -1,5 +1,6 @@</span>
<span style="color:{fg};"> use std::collections::*;</span>
{dm("-use std::env;")}{dp("+use std::env;")}{dp("+use std::path::PathBuf;")}<span style="color:{fg};"> fn main() {{</span>
</pre></div></div>{tb}</div></section></body></html>'''

themes = [
    ("cold","dark","/home/mdk/nvim/colorscheme-cold.html",
     {"bg":"#1C1B1F","cursorline":"#292830","comment":"#82849E","border":"#967F8E","fg":"#ECE0D0","red":"#D86060","yellow":"#E8B855","blue":"#8898C8","tan":"#D0A080","keyword":"#E88040","diff_bg":"#184050","diff_del":"#4C3038","diff_chg":"#302E48","diff_fg":"#50A8B8","context":"#564B56","visual":"#333138"},
     {"color0":"#292830","color1":"#A85050","color2":"#82849E","color3":"#C09838","color4":"#5868A8","color5":"#8A5888","color6":"#408888","color7":"#D0A080","color8":"#967F8E","color9":"#E88040","color10":"#50A8B8","color11":"#E8B855","color12":"#8898C8","color13":"#A878A8","color14":"#50A8B8","color15":"#ECE0D0","cursor":"#ECE0D0","cursor_text_color":"#1C1B1F","tab_bar_background":"#100F0F","inactive_tab_foreground":"#ECE0D0","active_border_color":"#bda04f"},"#100F0F"),
    ("cold","light","/home/mdk/nvim/colorscheme-cold-light.html",
     {"bg":"#EDEBE8","cursorline":"#E4E2DF","comment":"#5E5871","border":"#665767","fg":"#1C1828","red":"#9C3C3C","yellow":"#6E5A15","blue":"#4550B0","tan":"#785438","keyword":"#8D4A1B","diff_bg":"#B0D0E0","diff_del":"#DAAAA0","diff_chg":"#E0DCE8","diff_fg":"#206284","context":"#C8C0C0","visual":"#D8D0C4"},
     {"color0":"#E4E2DF","color1":"#9C3C3C","color2":"#5E5871","color3":"#987830","color4":"#4550B0","color5":"#7A4878","color6":"#387878","color7":"#785438","color8":"#665767","color9":"#8D4A1B","color10":"#3A7A58","color11":"#6E5A15","color12":"#4550B0","color13":"#8A5080","color14":"#206284","color15":"#1C1828","cursor":"#1C1828","cursor_text_color":"#EDEBE8","tab_bar_background":"#E4E2DF","inactive_tab_foreground":"#1C1828","active_border_color":"#bda04f"},"#E4E2DF"),
    ("warm","dark","/home/mdk/nvim/colorscheme-warm.html",
     {"bg":"#232521","cursorline":"#34302C","comment":"#7A9180","border":"#887663","fg":"#ECE1D7","red":"#CF5454","yellow":"#EBC06D","blue":"#A3A9CE","tan":"#C1A78E","keyword":"#E67E40","diff_bg":"#001B29","diff_del":"#3D0100","diff_chg":"#2B2F33","diff_fg":"#5BA0C2","context":"#554B40","visual":"#3E3935"},
     {"color0":"#34302C","color1":"#BD8183","color2":"#7A9180","color3":"#E49B5D","color4":"#7F91B2","color5":"#B380B0","color6":"#7B9695","color7":"#C1A78E","color8":"#887663","color9":"#D47766","color10":"#85B695","color11":"#EBC06D","color12":"#A3A9CE","color13":"#CF9BC2","color14":"#89B3B6","color15":"#ECE1D7","cursor":"#ECE1D7","cursor_text_color":"#232521","tab_bar_background":"#1C1F1C","inactive_tab_foreground":"#ECE1D7","active_border_color":"#bda04f"},"#1C1F1C"),
    ("warm","light","/home/mdk/nvim/colorscheme-warm-light.html",
     {"bg":"#F0EBE1","cursorline":"#E5DED2","comment":"#52605A","border":"#685B4E","fg":"#3B3530","red":"#A43838","yellow":"#725A11","blue":"#4A50B0","tan":"#705942","keyword":"#914A1A","diff_bg":"#B2D2E2","diff_del":"#DCADA5","diff_chg":"#E2E0E8","diff_fg":"#266385","context":"#D0C8C0","visual":"#D2C8B8"},
     {"color0":"#E5DED2","color1":"#A43838","color2":"#52605A","color3":"#86652D","color4":"#4A50B0","color5":"#7A4878","color6":"#4A6E6E","color7":"#705942","color8":"#685B4E","color9":"#914A1A","color10":"#3C7653","color11":"#725A11","color12":"#4A50B0","color13":"#8A5080","color14":"#266385","color15":"#3B3530","cursor":"#3B3530","cursor_text_color":"#F0EBE1","tab_bar_background":"#E8E3D9","inactive_tab_foreground":"#3B3530","active_border_color":"#bda04f"},"#E8E3D9"),
]

for s, v, path, p, k, uf in themes:
    with open(path, "w") as f:
        f.write(gen(s, v, p, k, uf))
    print(f"wrote {path}")
