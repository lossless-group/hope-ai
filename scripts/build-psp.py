"""Style pandoc's HTML so it survives a paste into Google Docs."""
import re, sys

raw, dest = sys.argv[1], sys.argv[2]
h = open(raw, encoding='utf-8').read()

TBL  = 'border-collapse:collapse;border:1px solid #000;width:100%;margin:12px 0;'
CELL = ('border:1px solid #000;padding:6px 8px;vertical-align:top;'
        'font-family:Arial,sans-serif;font-size:10pt;font-weight:normal;')
# Labels sit in the header row and stay bold. Responses live in body cells and are
# left plain — the box already marks them as the answer.
HEAD = CELL.replace('font-weight:normal;', 'font-weight:bold;') + 'text-align:left;'

# Each goal heading becomes the template's two-column header row: a narrow label
# cell, then the goal text as a real heading so the Google Docs outline still works.
def goal_row(m):
    # pandoc hard-wraps, so the heading text arrives with newlines inside it
    text = ' '.join(re.sub(r'<[^>]+>', '', m.group(0)).split())
    if not re.match(r'(Personal|Creative) Goal \d', text):
        return m.group(0)
    label, _, rest = text.partition(': ')
    return (f'<table style="{TBL}"><tbody><tr>'
            f'<td style="{HEAD}width:22%;">{label}</td>'
            f'<td style="{CELL}"><h3 style="margin:0;font-family:Arial,sans-serif;'
            f'font-size:13pt;">{rest}</h3></td>'
            f'</tr></tbody></table>')

h = re.sub(r'<h3\b[^>]*>.*?</h3>', goal_row, h, flags=re.S)

h = re.sub(r'<table\b[^>]*>', f'<table style="{TBL}">', h)
h = re.sub(r'<td(?=[\s>])(?![^>]*border)[^>]*>', f'<td style="{CELL}">', h)
h = re.sub(r'<th(?=[\s>])[^>]*>', f'<th style="{HEAD}">', h)
h = re.sub(r'<colgroup>.*?</colgroup>', '', h, flags=re.S)
h = h.replace('text-decoration: underline', '').replace('<u>', '').replace('</u>', '')

for tag, style in [
    ('h1', 'font-family:Arial,sans-serif;font-size:20pt;margin:18px 0 8px;'),
    ('h2', 'font-family:Arial,sans-serif;font-size:16pt;margin:18px 0 8px;'),
    ('h4', 'font-family:Arial,sans-serif;font-size:11pt;margin:12px 0 6px;'),
    ('p',  'font-family:Arial,sans-serif;font-size:11pt;line-height:1.4;margin:8px 0;'),
    ('li', 'font-family:Arial,sans-serif;font-size:11pt;line-height:1.4;margin:4px 0;'),
]:
    h = re.sub(rf'<{tag}(?=[\s>])[^>]*>', f'<{tag} style="{style}">', h)

open(dest, 'w', encoding='utf-8').write(
    '<!doctype html><html><head><meta charset="utf-8">'
    '<title>Personal Strategic Plan</title></head>'
    '<body style="font-family:Arial,sans-serif;font-size:11pt;'
    'max-width:960px;margin:24px auto;padding:0 16px;">' + h + '</body></html>')

out = open(dest, encoding='utf-8').read()
goals = len(re.findall(r'width:22%', out))
malformed = len(re.findall(r'<th style[^>]*>\s*<tr>', out))
print('goal rows:', goals, '| tables:', out.count('<table style'), '| malformed:', malformed)
